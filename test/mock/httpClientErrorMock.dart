import 'dart:io';

import 'package:dio/dio.dart';

class HTTPClientErrorMock {
  static Future<Response<dynamic>> getErrorResponse(Response<dynamic> response) async {
    final String responseData =
        '{"status":"error","error":"unauthorized","error_description":"Invalid Request."}';
    response = await Dio().reject(
        Response<dynamic>(data: responseData, statusCode: HttpStatus.unauthorized));
    return response;
  }
}
