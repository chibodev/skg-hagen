import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/library/globals.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
     return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final String keyData = "${response.requestOptions.path}/data";
    final String keyCache = response.requestOptions.path;

    sharedPreferences.setString(keyData, response.toString());
    sharedPreferences.setBool(keyCache, true);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.other) {
      final String keyData = "${err.requestOptions.path}/data";
      final String keyCache = err.requestOptions.path;

      final dynamic cachedResponse = sharedPreferences.get(keyData);
      if (cachedResponse != null) {
        return handler.next(cachedResponse);
      } else {
        sharedPreferences.setBool(keyCache, false);
      }
    }
    return handler.next(err);
  }
}
