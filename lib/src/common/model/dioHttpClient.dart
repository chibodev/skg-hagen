import 'package:dio/dio.dart';

class DioHTTPClient {
  static const String BASE_URL = 'https://skg-hagen.chibo.org/wp-json/api/v1/';
  static const int TIMEOUT = 5000;

  Dio _client;

  DioHTTPClient() {
    final BaseOptions options = BaseOptions(
        baseUrl: BASE_URL, connectTimeout: TIMEOUT, receiveTimeout: TIMEOUT);
    _client = Dio(options);
  }

  Dio get client => _client;
}
