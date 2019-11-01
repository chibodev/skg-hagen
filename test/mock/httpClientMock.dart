import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class HTTPClientMock {
  static Future<Response> tokenPost({int statusCode}) async {
    Response response;

    switch (statusCode) {
      case HttpStatus.ok:
        String responseData;
        final List<String> tokenList = "aBCdEFgHIjkLMN1234567890".split("")
          ..shuffle();
        responseData =
            '{"token_type":"Bearer","iat":1572514891,"expires_in":1572518491,"jwt_token":"${tokenList.join()}"}';
        response = await Dio()
            .resolve(Response(data: responseData, statusCode: statusCode));
        break;

      default:
        response = await _getErrorResponse(response);
        break;
    }

    return response;
  }

  static Future<Response> monthlyScriptureGet({int statusCode}) async {
    Response response;

    switch (statusCode) {
      case HttpStatus.ok:
        String responseData =
            '[{"text":"Suchet der Stadt Beste","book":"Jeremia","chapter":"27","verse":"12","validity":"2019-10-29"}]';
        response = await Dio().resolve(
            Response(data: jsonDecode(responseData), statusCode: statusCode));
        break;

      default:
        response = await _getErrorResponse(response);
        break;
    }

    return response;
  }

  static Future<Response> _getErrorResponse(Response response) async {
    final String responseData =
        '{"status":"error","error":"unauthorized","error_description":"Invalid Request."}';
    response = await Dio().reject(
        Response(data: responseData, statusCode: HttpStatus.unauthorized));
    return response;
  }
}
