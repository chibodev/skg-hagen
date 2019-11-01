class Token {
  String tokenType;
  int iat;
  int expiresIn;
  String jwtToken;

  Token({
    this.tokenType,
    this.expiresIn,
    this.jwtToken,
    this.iat,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        tokenType: json["token_type"] == null ? null : json['token_type'],
        iat: json["iat"] == null ? null : json['iat'],
        expiresIn: json["expires_in"] == null ? null : json['expires_in'],
        jwtToken: json["jwt_token"] == null ? null : json['jwt_token'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "token_type": tokenType == null ? null : tokenType,
        "expires_in": expiresIn == null ? null : expiresIn,
        "iat": iat == null ? null : iat,
        "jwt_token": jwtToken == null ? null : jwtToken,
      };
}
