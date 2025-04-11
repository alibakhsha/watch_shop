import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<Response> post(String path, {dynamic data, Map<String, String>? headers}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path, {Map<String, dynamic>? headers}) async {
    return await dio.get(path, options: Options(headers: headers));
  }
}
