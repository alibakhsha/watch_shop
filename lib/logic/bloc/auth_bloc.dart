import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/model/check_sms.dart';
import '../../core/model/send_sms.dart';
import '../../services/api_sevice.dart';
import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthBloc(this.apiService) : super(AuthInitial()) {
    on<SendSmsEvent>(_onSendSms);
    on<CheckSmsCodeEvent>(_onCheckSmsCode);
  }

  Future<void> _onSendSms(SendSmsEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      FormData formData = FormData.fromMap({'mobile': event.mobile});
      final response = await apiService.post('/public/api/v1/send_sms', data: formData);

      debugPrint('SendSms Response Status: ${response.statusCode}');
      debugPrint('SendSms Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final sendSmsResponse = SendSmsResponse.fromJson(response.data);
        emit(AuthSuccess(message: sendSmsResponse.message));
      } else {
        emit(AuthFailure(error: 'Failed to send SMS: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AuthFailure(error: 'Error sending SMS: $e'));
    }
  }

  Future<void> _onCheckSmsCode(CheckSmsCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      FormData formData = FormData.fromMap({
        'mobile': event.mobile,
        'code': event.code,
      });
      final response = await apiService.post('/public/api/v1/check_sms_code', data: formData);

      debugPrint('CheckSmsCode Response Status: ${response.statusCode}');
      debugPrint('CheckSmsCode Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final checkSmsResponse = CheckSmsCodeResponse.fromJson(response.data);
        final token = checkSmsResponse.data.token;
        debugPrint('Token sent to SmsCodeVerified: $token');
        emit(SmsCodeVerified(
          message: checkSmsResponse.message,
          token: token,
        ));
      } else {
        emit(AuthFailure(error: 'Failed to verify code: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('CheckSmsCode Error: $e');
      emit(AuthFailure(error: 'Error verifying code: $e'));
    }
  }
}