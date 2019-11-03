import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'fileClientMock.dart';
import 'httpClientErrorMock.dart';

class HTTPClientMonthlyScriptureMock {
  static Future<Response<dynamic>> monthlyScriptureGet({int statusCode}) async {
    Response<dynamic> response;

    switch (statusCode) {
      case HttpStatus.ok:
        final String responseData =
            await FileClientMock.loadFromTestResourcePath(
                'monthlyScripture.json');
        response = await Dio().resolve(Response<dynamic>(
            data: jsonDecode(responseData), statusCode: statusCode));
        break;

      default:
        response = await HTTPClientErrorMock.getErrorResponse(response);
        break;
    }

    return response;
  }
}
