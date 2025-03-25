// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/services/api_sevice.dart';

import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;

  AuthBloc({required this.apiService}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SendOtpEvent) {
      yield AuthSending();

      try {
        final response = await apiService.sendSms(event.mobile);
        if (response.result) {
          yield AuthSuccess(code: response.data.code);
        } else {
          yield AuthFailure(error: "ارسال پیامک با مشکل مواجه شد");
        }
      } catch (e) {
        yield AuthFailure(error: "خطا در ارسال پیامک");
      }
    }
  }
}
