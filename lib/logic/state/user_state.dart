import 'package:watch_shop/core/model/user_data.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserData user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
