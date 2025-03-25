import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/api_sevice.dart';
import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthBloc({required this.apiService}) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await apiService.sendSms(event.mobile);
        emit(AuthSuccess(message: response.message));
      } catch (e) {
        emit(AuthFailure(error: 'ارسال پیامک با خطا مواجه شد'));
      }
    });

    on<CheckSmsCodeEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await apiService.checkSmsCode(event.mobile, event.code);

        await secureStorage.write(key: 'token', value: response.data.token);

        emit(SmsCodeVerified(message: response.message, token: response.data.token));
      } catch (e) {
        emit(AuthFailure(error: 'کد تایید اشتباه است'));
      }
    });
  }
}
