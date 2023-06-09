import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

import 'fileClientMock.dart';
import 'httpClientErrorMock.dart';

class MockNetwork extends Mock implements Network {
  @override
  Future<bool> hasInternet() {
    return super.noSuchMethod(Invocation.method(#hasInternet, null),
        returnValue: Future<bool>.value(true));
  }
}

class MockDioHTTPClient extends Mock implements DioHTTPClient {
  @override
  Future<Options> setOptions(
      DioHTTPClient? http, Network? network, bool? refresh) {
    return super.noSuchMethod(
        Invocation.method(#setOptions, <dynamic>[http, network, refresh]),
        returnValue: Future<Options>.value(Options()));
  }

  @override
  Map<String, dynamic> getQueryParameters({int? index = 0}) {
    return super.noSuchMethod(
        Invocation.method(#getQueryParameters, <dynamic>[index]),
        returnValue: Map<String, dynamic>());
  }

  @override
  Future<dynamic> getJSONResponse(
      {DioHTTPClient? http,
      Options? options,
      Map<String, dynamic>? queryParameters,
      String? path,
      dynamic object,
      String? cacheData}) {
    return super.noSuchMethod(
        Invocation.method(#getJSONResponse, <dynamic>[
          {http, options, queryParameters, path, object, cacheData}
        ]),
        returnValue: Future<dynamic>.value('{}'));
  }
}

class HTTPClientMock {
  static Future<dynamic> getJSONRequest(
      {required int statusCode, String? path}) async {
    dynamic response;

    switch (statusCode) {
      case HttpStatus.ok:
        response = await FileClientMock.loadFromTestResourcePath(path!);
        break;

      default:
        response = HTTPClientErrorMock.getErrorResponse();
        break;
    }

    return jsonDecode(response);
  }

  static Future<dynamic> getHTMLRequest(
      {required int statusCode, String? path}) async {
    dynamic response;

    switch (statusCode) {
      case HttpStatus.ok:
        response = await FileClientMock.loadFromTestResourcePath(path!);
        break;

      default:
        response = jsonDecode(HTTPClientErrorMock.getErrorResponse());
        break;
    }

    return response;
  }
}
