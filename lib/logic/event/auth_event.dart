import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendSmsEvent extends AuthEvent {
  final String mobile;

  SendSmsEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class CheckSmsCodeEvent extends AuthEvent {
  final String mobile;
  final String code;

  CheckSmsCodeEvent(this.mobile, this.code);

  @override
  List<Object?> get props => [mobile, code];
}
