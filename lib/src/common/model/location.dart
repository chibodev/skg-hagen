import 'dart:core';

class Location {

  String _location;

  static const String _MARKUS_CHURCH = 'markuskirche';
  static const String _JOHANNIS_CHURCH = 'johanniskirche';

  // TODO: add longitude and latitide
  static const String _LONG_LAT_MARKUS = '51.369311, 7.471246';
  static const String _LONG_LAT_JOHANNIS = '51.355742, 7.477465';

  static const List<String> VALID_LOCATIONS = <String>[
    _MARKUS_CHURCH,
    _JOHANNIS_CHURCH
  ];

  static const Map<String, String> MAPPER = <String, String>{
    _MARKUS_CHURCH: _LONG_LAT_MARKUS,
    _JOHANNIS_CHURCH: _LONG_LAT_JOHANNIS
  };


  Location(String location) {
    if (!VALID_LOCATIONS.contains(location)) {
      throw 'unknown location $location given';
    }
    _location = location;
  }

  String getLongtideLatitude() {
    return MAPPER[_location];
  }
}
