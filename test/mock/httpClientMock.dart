import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'fileClientMock.dart';
import 'httpClientErrorMock.dart';

class HTTPClientMock {
  static Future<dynamic> getRequest({int statusCode, String path}) async {
    dynamic response;

    switch (statusCode) {
      case HttpStatus.ok:
        final String responseData =
            await FileClientMock.loadFromTestResourcePath(path);
        response = await Dio().resolve(Response<dynamic>(
            data: jsonDecode(responseData), statusCode: statusCode));
            response = response.data;
        break;

      default:
        response = await HTTPClientErrorMock.getErrorResponse(response);
        break;
    }

    return response;
  }
}
