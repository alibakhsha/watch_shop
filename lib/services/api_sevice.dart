import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/model/check_sms.dart';
import '../core/model/send_sms.dart';

import '../core/model/user_data.dart';

class ApiService {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ApiService() {
    dio.options.baseUrl = 'https://watchstore.sasansafari.com';
    dio.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<SendSmsResponse> sendSms(String mobile) async {
    try {
      FormData formData = FormData.fromMap({'mobile': mobile});

      final response = await dio.post(
        '/public/api/v1/send_sms',
        data: formData,
      );
      print('Response Status Code: ${response.statusCode}'); // نمایش کد وضعیت
      print('Response Data: ${response.data}'); // نمایش محتوای دریافتی
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendSmsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to send SMS');
      }
    } catch (e) {
      print('Error in sendSms: $e');
      rethrow;
    }
  }

  Future<CheckSmsCodeResponse> checkSmsCode(String mobile, String code) async {
    try {
      FormData formData = FormData.fromMap({'mobile': mobile, 'code': code});

      final response = await dio.post(
        '/public/api/v1/check_sms_code',
        data: formData,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckSmsCodeResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to verify SMS code');
      }
    } catch (e) {
      print('Error in checkSmsCode: $e');
      rethrow;
    }
  }

  Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
    try {

      String? token = await getToken();

      if (token == null) {
        throw Exception('No token available');
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      List<MultipartFile> imageFiles = [];

      if (request.imagePaths != null) {
        for (String imagePath in request.imagePaths!) {
          imageFiles.add(await MultipartFile.fromFile(
            imagePath,
            filename: 'profile_image.jpg',
          ));
        }
      }


      FormData formData = FormData.fromMap({
        'name': request.name,
        'phone': request.phone,
        'address': request.address,
        'postal_code': request.postalCode,
        'lat': request.lat,
        'lng': request.lng,
        if (imageFiles.isNotEmpty) 'image': imageFiles,
      });

      final response = await dio.post(
        '/public/api/v1/register',
        data: formData,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('User Data: ${response.data['data']['user']}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterUserResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error in registerUser: $e');
      rethrow;
    }
  }
}
