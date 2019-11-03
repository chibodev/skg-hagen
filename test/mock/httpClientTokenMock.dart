import 'dart:io';

import 'package:dio/dio.dart';

import 'httpClientErrorMock.dart';

class HTTPClientTokenMock {
  static Future<Response<dynamic>> tokenPost({int statusCode}) async {
    Response<dynamic> response;

    switch (statusCode) {
      case HttpStatus.ok:
        String responseData;
        final List<String> tokenList = "aBCdEFgHIjkLMN1234567890".split("")
          ..shuffle();
        responseData =
            '{"token_type":"Bearer","iat":1572514891,"expires_in":1572518491,"jwt_token":"${tokenList.join()}"}';
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
