class Token {
  String tokenType;
  int iat;
  int expiresIn;
  String jwtToken;

  Token({
    required this.tokenType,
    required this.expiresIn,
    required this.jwtToken,
    required this.iat,
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
