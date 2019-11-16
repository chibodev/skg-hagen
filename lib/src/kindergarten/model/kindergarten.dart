import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart';

class Kindergarten {
  final List<Events> events;
  final List<News> news;
  static const String NAME = 'Ev.Kindergarten';
  static const String IMAGE = 'assets/images/kindergarten.jpg';
  static const String FOOTER =
      'Für weitere Infos bitte direkt an das Kindergarten wenden.';

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
