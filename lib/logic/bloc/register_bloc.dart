import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/model/user_data.dart';
import '../../services/api_sevice.dart';
import '../event/register_event.dart';
import '../state/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiService apiService;

  RegisterBloc({required this.apiService}) : super(RegisterInitial()) {
    on<RegisterUserEvent>(
      _registerUser,
    );
  }


  Future<void> _registerUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterLoading());

      print('name: ${event.name}');
      print('phone: ${event.phone}');
      print('address: ${event.address}');
      print('postal_code: ${event.postalCode}');
      print('lat: ${event.lat}');
      print('lng: ${event.lng}');
      print('imagePaths: ${event.imagePaths}');

      final request = RegisterUserRequest(
        name: event.name,
        phone: event.phone,
        address: event.address,
        postalCode: event.postalCode,
        lat: event.lat,
        lng: event.lng,
        imagePaths: event.imagePaths,
      );

      final response = await apiService.registerUser(request);

      if (response.result) {
        emit(RegisterSuccess(response.message));
      } else {
        emit(RegisterFailure(response.message));
      }
    } catch (e) {
      emit(RegisterFailure('خطا در ارسال اطلاعات'));
    }
  }
}
