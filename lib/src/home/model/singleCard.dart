import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';

class SingleCard {
  List _cards = new List<CardContent>();

  List getAllCards() {
    _setCards();
    return _cards;
  }

  void _setCards() {
    //TODO: Retrieve data for 'home' from a config file (yaml for instance)
    _cards.add(_createNewCard(
        'termine',
        ['GOTTESDIENSTE', 'VERANSTALTUNGEN', 'EVENTS'],
        Routes.appointment,
        'images/termine.jpg'));
    _cards.add(_createNewCard('angebote', ['GRUPPEN', 'KREISEN', 'MUSIK'],
        Routes.appointment, 'images/angebote.jpg'));
    _cards.add(_createNewCard('andacht', ['ZUSPRUCH', 'PREDIGT'],
        Routes.appointment, 'images/andacht.jpg'));
    _cards.add(_createNewCard(
        'lesen', ['BIBEL'], Routes.appointment, 'images/lesen.jpg'));
    _cards.add(_createNewCard(
        'gebet', ['GEBETSWUNSCH'], Routes.appointment, 'images/gebet.jpg'));
    _cards.add(_createNewCard(
        'spende', ['KOLLEKTE'], Routes.appointment, 'images/spende.jpg'));
    _cards.add(_createNewCard(
        'kontakte',
        ['ADRESSE', 'ANSPRECHPARTNER', 'SOCIAL MEDIA'],
        Routes.appointment,
        'images/angebote.jpg'));
    _cards.add(_createNewCard(
        'Über uns',
        ['GESCHICHTE', 'DAS PRESBYTERIUM', 'IMPRESSUM'],
        Routes.appointment,
        'images/angebote.jpg'));
  }

  CardContent _createNewCard(String title, List subtitle, String routeName,
      [String imagePath]) {
    return new CardContent(title, subtitle, routeName, imagePath);
  }
}
