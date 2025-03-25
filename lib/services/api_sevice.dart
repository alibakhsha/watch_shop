import 'package:dio/dio.dart';

import '../core/model/send_sms.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.options.baseUrl = 'https://watchstore.sasansafari.com';
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }
  Future<SendSmsResponse> sendSms(String mobile) async {
    try {
      final response = await dio.post(
        '/public/api/v1/send_sms',
        data: SendSmsRequest(mobile: mobile).toJson(),
      );

      if (response.statusCode == 200) {
        return SendSmsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to send SMS');
      }
    } catch (e) {
      rethrow;
    }
  }
}
