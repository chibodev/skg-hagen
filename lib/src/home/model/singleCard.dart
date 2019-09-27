import 'package:skg_hagen/src/common/model/customCard.dart';

class SingleCard {
  List _cards = new List<CustomCard>();

  List getAllCards() {
    _setCards();
    return _cards;
  }

  void _setCards() {
    //TODO: Retrieve data for 'home' from a config file (yaml for instance)
    _cards.add(_createNewCard('termine',
        ['GOTTESDIENSTE', 'VERANSTALTUNGEN', 'EVENTS'], 'images/termine.jpg'));
    _cards.add(_createNewCard(
        'angebote', ['GRUPPEN', 'KREISEN', 'MUSIK'], 'images/angebote.jpg'));
    _cards.add(_createNewCard(
        'andacht', ['ZUSPRUCH', 'PREDIGT'], 'images/andacht.jpg'));
    _cards.add(_createNewCard('lesen', ['BIBEL'], 'images/lesen.jpg'));
    _cards.add(_createNewCard('gebet', ['GEBETSWUNSCH'], 'images/gebet.jpg'));
    _cards.add(_createNewCard('spende', ['KOLLEKTE'], 'images/spende.jpg'));
    _cards.add(_createNewCard('kontakte',
        ['ADRESSE', 'ANSPRECHPARTNER', 'SOCIAL MEDIA'], 'images/angebote.jpg'));
    _cards.add(_createNewCard(
        'Über uns',
        ['GESCHICHTE', 'DAS PRESBYTERIUM', 'IMPRESSUM'],
        'images/angebote.jpg'));
  }

  CustomCard _createNewCard(String title, List subtitle,
      [String imagePath = null]) {
    return new CustomCard(title, subtitle, imagePath);
  }
}
