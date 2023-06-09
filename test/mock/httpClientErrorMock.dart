class HTTPClientErrorMock {
  static String getErrorResponse() {
    return '{"status":"error","error":"unauthorized","error_description":"Invalid Request."}';
  }
}
