
import 'dart:convert';

import 'package:skg_hagen/src/common/model/customCard.dart';

class SingleCard {
  List _cards = new List<CustomCard>();

  List getAllCards() {
    _setCards();
    return _cards;
  }

  void _setCards() {
    //TODO: Retrieve data for 'home' from a config file (yaml for instance)

    CustomCard card = new CustomCard('termine',
        ['GOTTESDIENSTE', 'VERANSTALTUNGEN', 'EVENTS'], 'images/termine.jpg');
    _cards.add(card);
    card = new CustomCard('angebote', ['GRUPPEN', 'KREISEN', 'MUSIK'], 'images/angebote.jpg');
    print (card);
    _cards.add(card);
    card = new CustomCard('andacht', ['ZUSPRUCH', 'PREDIGT'], 'images/andacht.jpg');
    _cards.add(card);
    card = new CustomCard('lesen', ['BIBEL'], 'images/lesen.jpg');
    _cards.add(card);
    card = new CustomCard('gebet', ['GEBETSWUNSCH'], 'images/gebet.jpg');
    _cards.add(card);
    card = new CustomCard('spende', ['KOLLEKTE'], 'images/spende.jpg');
    _cards.add(card);
    card = new CustomCard('kontakte', ['ADRESSE', 'ANSPRECHPARTNER', 'SOCIAL MEDIA'], 'images/angebote.jpg');
    _cards.add(card);
    card =
        new CustomCard("Über uns", ['GESCHICHTE', 'DAS PRESBYTERIUM', 'IMPRESSUM'], 'images/angebote.jpg');
    _cards.add(card);
  }
}
