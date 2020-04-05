class JsonResponse {
  final String status;
  final String error;

  JsonResponse({
    this.status,
    this.error,
  });

  factory JsonResponse.fromJson(Map<String, dynamic> json) => JsonResponse(
        status: json["status"] == null ? null : json['status'],
        error: json["error"] == null ? null : json['error'],
      );
}
