import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/token/service/tokenInterceptor.dart';

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

  void initialiseInterceptors(String options) {
    switch (options) {
      case 'debug':
        this.client.interceptors.add(DebugInterceptor());
        break;

      case 'cache':
        this
            .client
            .interceptors
            .add(DioCacheManager(CacheConfig()).interceptor);
        break;

      case 'token':
        this.client.interceptors.add(TokenInterceptor());
        break;
    }
  }

  Future<Response> post({String path, dynamic data, Options options}) async {
    return await this._client.post(path, options: options, data: data);
  }

  Future<Response> get({String path, Options options}) async {
    return await this._client.get(path, options: options);
  }
}
