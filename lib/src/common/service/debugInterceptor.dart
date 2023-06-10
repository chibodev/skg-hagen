import 'package:dio/dio.dart';

class DebugInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print("--> ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
    print("Headers:");
    options.headers.forEach((dynamic k, dynamic v) => print('$k: $v'));
    if (options.queryParameters.isNotEmpty) {
      print("queryParameters:");
      options.queryParameters.forEach((dynamic k, dynamic v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print("--> END ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'}");

    return handler.next(options);
  }

  @override
  Future<void> onError(DioError dioError, ErrorInterceptorHandler handler) async {
    print("<-- ${dioError.message} ${dioError.response?.requestOptions.baseUrl} ${dioError.response?.requestOptions.path}");
    print("${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    print("<-- End error");

    return handler.next(dioError);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    print("<-- ${response.statusCode} ${(response.requestOptions.baseUrl + response.requestOptions.path)}");
    print("Headers:");
    response.headers.forEach((dynamic k, dynamic v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");

    return handler.next(response);
  }
}
