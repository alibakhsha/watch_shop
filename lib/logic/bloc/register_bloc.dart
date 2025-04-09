// lib/logic/bloc/register_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watch_shop/core/model/user_data.dart';
import 'package:watch_shop/logic/event/register_event.dart';
import 'package:watch_shop/logic/state/register_state.dart';

import '../../services/api_sevice.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  RegisterBloc(this.apiService) : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
      RegisterUserEvent event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());
    try {
      // گرفتن توکن از SecureStorage
      String? token = await secureStorage.read(key: 'token');
      if (token == null) {
        emit(RegisterFailure('No token available'));
        return;
      }

      // تنظیم هدر Authorization
      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      // آماده‌سازی فایل‌های تصویر
      List<MultipartFile> imageFiles = [];
      if (event.imagePaths != null) {
        for (String imagePath in event.imagePaths!) {
          imageFiles.add(
            await MultipartFile.fromFile(
              imagePath,
              filename: 'profile_image.jpg',
            ),
          );
        }
      }

      // ساخت FormData
      FormData formData = FormData.fromMap({
        'name': event.name,
        'phone': event.phone,
        'address': event.address,
        'postal_code': event.postalCode,
        'lat': event.lat,
        'lng': event.lng,
        if (imageFiles.isNotEmpty) 'image': imageFiles,
      });

      // ارسال درخواست
      final response = await apiService.post(
        '/public/api/v1/register',
        data: formData,
      );

      // پرینت جزئیات پاسخ
      debugPrint('Register Response Status: ${response.statusCode}');
      debugPrint('Register Response Data: ${response.data}');
      debugPrint('User Data: ${response.data['data']['user']}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponse = RegisterUserResponse.fromJson(response.data);
        debugPrint('Parsed RegisterUserResponse: $registerResponse');

        // اضافه کردن imagePaths به UserData
        final userDataWithImages = UserData(
          id: registerResponse.data.id,
          name: registerResponse.data.name,
          mobile: registerResponse.data.mobile,
          phone: registerResponse.data.phone,
          address: registerResponse.data.address,
          imagePaths: event.imagePaths, // مسیرهای محلی رو نگه می‌داریم
        );

        emit(RegisterSuccess(registerResponse.message, userDataWithImages));
      } else {
        emit(
          RegisterFailure('Failed to register user: ${response.statusCode}'),
        );
      }
    } catch (e) {
      debugPrint('Register Error: $e');
      emit(RegisterFailure('Error registering user: $e'));
    }
  }
}