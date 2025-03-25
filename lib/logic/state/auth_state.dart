
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSending extends AuthState {}

class AuthSuccess extends AuthState {
  final String code; // کد تایید که از API دریافت می‌شود

  AuthSuccess({required this.code});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
