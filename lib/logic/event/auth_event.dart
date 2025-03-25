// AuthEvent.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobile;

  SendOtpEvent({required this.mobile});

  @override
  List<Object?> get props => [mobile];
}

class CheckSmsCodeEvent extends AuthEvent {
  final String code;
  final String mobile;

  CheckSmsCodeEvent({required this.code, required this.mobile});

  @override
  List<Object?> get props => [code, mobile];
}
