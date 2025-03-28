import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/model/check_sms.dart';
import '../core/model/send_sms.dart';

import '../core/model/user_data.dart';

class ApiService {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ApiService() {
    dio.options.baseUrl = 'https://watchstore.sasansafari.com';
    dio.options.headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path, {Map<String, dynamic>? headers}) async {
    return await dio.get(
      path,
      options: Options(headers: headers),
    );
  }

  // Future<Map<String, dynamic>> getHomeData() async {
  //   try {
  //     final response = await dio.get(
  //       '/public/api/v1/home',
  //       options: Options(
  //         headers: {
  //           'accept': 'application/json',
  //           'X-CSRF-TOKEN': '',
  //         },
  //       ),
  //     );
  //
  //     debugPrint('Home Data Response: ${response.data}');
  //
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       throw Exception('Failed to load home data');
  //     }
  //   } catch (e) {
  //     debugPrint('Error in getHomeData: $e');
  //     rethrow;
  //   }
  // }
}
