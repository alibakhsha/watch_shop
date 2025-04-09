import 'package:watch_shop/core/model/user_data.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  final UserData user;
  RegisterSuccess(this.message,this.user);
}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
