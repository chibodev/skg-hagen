import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
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
          <dynamic>{http, options, queryParameters, path, object, cacheData}
        ]),
        returnValue: Future<dynamic>.value('{}'));
  }

  @override
  Future<dynamic> getHTMLResponse(
      {DioHTTPClient? http,
      Options? options,
      String? path,
      String? cacheData}) {
    return super.noSuchMethod(
        Invocation.method(#getHTMLResponse, <dynamic>[
          <dynamic>{http, options, path, cacheData}
        ]),
        returnValue: Future<dynamic>.value(''));
  }

  @override
  Future<dynamic> postJSON(
      {DioHTTPClient? http, Options? options, String? path, dynamic data}) {
    return super.noSuchMethod(
        Invocation.method(#postJSON, <dynamic>[
          <dynamic>{http, options, path, data}
        ]),
        returnValue: Future<Response<dynamic>>.value(Response<dynamic>(
            data: '',
            statusCode: 200,
            requestOptions: RequestOptions(path: path!))));
  }

  @override
  Future<bool> downloadFile(
      {DioHTTPClient? http, String? urlPath, String? savePath}) {
    return super.noSuchMethod(
        Invocation.method(#downloadFile, <dynamic>[
          <dynamic>{http, urlPath, savePath}
        ]),
        returnValue: Future<bool>.value(true));
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
        response = Document.html(response);
        break;

      default:
        response = jsonDecode(HTTPClientErrorMock.getErrorResponse());
        break;
    }

    return response;
  }

  static Response<dynamic> formPost(
      {required String path, required int statusCode}) {
    String responseData = '';

    switch (statusCode) {
      case HttpStatus.ok:
        responseData = '{"status":"success","error":null}';
        break;

      case HttpStatus.badRequest:
        responseData =
            '{"status":"failed","error":"unable to save intercession/invalid intercession: ..."}';
        break;

      default:
        responseData = HTTPClientErrorMock.getErrorResponse();
        break;
    }

    return Response<dynamic>(
        data: responseData,
        statusCode: statusCode,
        requestOptions: RequestOptions(path: path));
  }

  static Future<dynamic> tokenPost({required int statusCode}) async {
    dynamic response;

    switch (statusCode) {
      case HttpStatus.ok:
        final List<String> tokenList = "aBCdEFgHIjkLMN1234567890".split("")
          ..shuffle();
        response =
            '{"token_type":"Bearer","iat":1572514891,"expires_in":1572518491,"jwt_token":"${tokenList.join()}"}';
        break;

      default:
        response = HTTPClientErrorMock.getErrorResponse();
        break;
    }

    return response;
  }
}
