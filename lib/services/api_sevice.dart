import 'package:dio/dio.dart';

import '../core/model/check_sms.dart';
import '../core/model/send_sms.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.options.baseUrl = 'https://watchstore.sasansafari.com';
    dio.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
  }

  Future<SendSmsResponse> sendSms(String mobile) async {
    try {
      FormData formData = FormData.fromMap({'mobile': mobile});

      final response = await dio.post(
        '/public/api/v1/send_sms',
        data: formData,
      );
      print('Response Status Code: ${response.statusCode}'); // نمایش کد وضعیت
      print('Response Data: ${response.data}'); // نمایش محتوای دریافتی
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendSmsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to send SMS');
      }
    } catch (e) {
      print('Error in sendSms: $e');
      rethrow;
    }
  }

  Future<CheckSmsCodeResponse> checkSmsCode(String mobile, String code) async {
    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
        'code': code,
      });

      final response = await dio.post(
        '/public/api/v1/check_sms_code',
        data: formData,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckSmsCodeResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to verify SMS code');
      }
    } catch (e) {
      print('Error in checkSmsCode: $e');
      rethrow;
    }
  }
}
