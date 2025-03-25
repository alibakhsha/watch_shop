
abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String mobile;

  SendOtpEvent({required this.mobile});
}
