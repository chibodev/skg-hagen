import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/library/globals.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    return options;
  }

  @override
  Future<dynamic> onResponse(Response<dynamic> response) async {
    final String keyData = "${response.request.path}/data";
    final String keyCache = response.request.path;

    sharedPreferences.setString(keyData, response.toString());
    sharedPreferences.setBool(keyCache, true);
  }

  @override
  Future<dynamic> onError(DioError e) async {
    print('onError: $e');
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.DEFAULT) {
      final String keyData = "${e.request.path}/data";
      final String keyCache = e.request.path;

      final dynamic cachedResponse = sharedPreferences.get(keyData);
      if (cachedResponse != null) {
        return cachedResponse;
      } else {
        sharedPreferences.setBool(keyCache, false);
      }
    }
    return e;
  }
}
