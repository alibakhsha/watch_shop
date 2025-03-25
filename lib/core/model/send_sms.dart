class SendSmsRequest {
  final String mobile;

  SendSmsRequest({required this.mobile});

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
    };
  }
}


class SendSmsResponse {
  final bool result;
  final String message;
  final SmsData data;

  SendSmsResponse({required this.result, required this.message, required this.data});

  factory SendSmsResponse.fromJson(Map<String, dynamic> json) {
    return SendSmsResponse(
      result: json['result'],
      message: json['message'],
      data: SmsData.fromJson(json['data']),
    );
  }
}

class SmsData {
  final String mobile;
  final int code;

  SmsData({required this.mobile, required this.code});

  factory SmsData.fromJson(Map<String, dynamic> json) {
    return SmsData(
      mobile: json['mobile'],
      code: json['code'],
    );
  }
}
