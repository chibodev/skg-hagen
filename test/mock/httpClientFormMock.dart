import 'dart:io';

import 'package:dio/dio.dart';

import 'httpClientErrorMock.dart';

class HTTPClientFormMock {
  static Future<Response<dynamic>> formPost({int statusCode}) async {
    Response<dynamic> response;

    switch (statusCode) {
      case HttpStatus.ok:
        String responseData;
        responseData =
            '{"status":"success","error":null}';
        response = await Dio().resolve(
            Response<dynamic>(data: responseData, statusCode: statusCode));
        break;

      case HttpStatus.badRequest:
        String responseData;
        responseData =
        '{"status":"failed","error":"unable to save intercession/invalid intercession: ..."}';
        response = await Dio().resolve(
            Response<dynamic>(data: responseData, statusCode: statusCode));
        break;

      default:
        response = await HTTPClientErrorMock.getErrorResponse(response);
        break;
    }

    return response;
  }
}
