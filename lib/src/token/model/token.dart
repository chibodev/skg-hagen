class Token {
  String tokenType;
  int iat;
  int expiresIn;
  String jwtToken;
  String _errorText;

  Token({
    this.tokenType,
    this.expiresIn,
    this.jwtToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        tokenType: json["token_type"] == null ? null : json['token_type'],
        expiresIn: json["expires_in"] == null ? null : json['expires_in'],
        jwtToken: json["jwt_token"] == null ? null : json['jwt_token'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "token_type": tokenType == null ? null : tokenType,
        "expires_in": expiresIn == null ? null : expiresIn,
        "jwt_token": jwtToken == null ? null : jwtToken,
      };

  void withError(String error) {
    _errorText = error;
  }

  String get errorText => _errorText;
}
