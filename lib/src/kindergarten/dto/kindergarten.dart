import 'package:skg_hagen/src/kindergarten/dto/events.dart';
import 'package:skg_hagen/src/kindergarten/dto/news.dart';

class Kindergarten {
  final List<Events> events;
  final List<News> news;
  static const String NAME = 'Ev.Kindergarten';
  static const String IMAGE = 'assets/images/kindergarten.jpg';
  static const String FOOTER =
      'Für weitere Informationen wenden Sie sich bitte an Mitarbeiter des Kindergartens.';

  Kindergarten({this.events, this.news});

  factory Kindergarten.fromJson(Map<String, dynamic> json) {
    return Kindergarten(
      events: List<Events>.from(
        json["events"].map(
          (dynamic x) => Events.fromJson(x),
        ),
      ),
      news: List<News>.from(
        json["news"].map((dynamic x) => News.fromJson(x)),
      ),
    );
  }
}
