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
        tokenType: json["token_type"],
        iat: json["iat"],
        expiresIn: json["expires_in"],
        jwtToken: json["jwt_token"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "token_type": tokenType,
        "expires_in": expiresIn,
        "iat": iat,
        "jwt_token": jwtToken,
      };
}
