class CheckSmsCodeResponse {
  final bool result;
  final String message;
  final CheckSmsCodeData data;

  CheckSmsCodeResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  factory CheckSmsCodeResponse.fromJson(Map<String, dynamic> json) {
    return CheckSmsCodeResponse(
      result: json['result'],
      message: json['message'],
      data: CheckSmsCodeData.fromJson(json['data']),
    );
  }
}

class CheckSmsCodeData {
  final int id;
  final bool isRegistered;
  final String token;

  CheckSmsCodeData({
    required this.id,
    required this.isRegistered,
    required this.token,
  });

  factory CheckSmsCodeData.fromJson(Map<String, dynamic> json) {
    return CheckSmsCodeData(
      id: json['id'],
      isRegistered: json['is_registered'],
      token: json['token'],
    );
  }
}
