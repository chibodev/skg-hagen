class Social {
  static const String FACEBOOK = 'assets/images/icon/facebook.png';
  static const String INSTAGRAM = 'assets/images/icon/instagram.png';
  static const String TWITTER = 'assets/images/icon/twitter.png';
  static const String WHATSAPP = 'assets/images/icon/whatsapp.png';
  static const String NAME = 'Social Media';

  static const List<String> VALID_SOCIAL = <String>[
    'facebook', 'instagram', 'twitter', 'whatsapp'
  ];

  String name;
  String url;
  String location;

  Social({
    this.name,
    this.url,
    this.location
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        name: json["name"],
        url: json["url"],
        location: json["location"],
      );

  bool isSocialValid(String name) =>  VALID_SOCIAL.contains(name);

  String getSocialImage(String name) {
    String imagePath;

    switch (name) {
      case 'facebook':
        imagePath = FACEBOOK;
        break;
      case 'instagram':
        imagePath = INSTAGRAM;
        break;
      case 'twitter':
        imagePath = TWITTER;
        break;
      case 'whatsapp':
        imagePath = WHATSAPP;
        break;
    }

    return imagePath;
  }
}
