class Address {
  String _churchName;
  String _address1;
  String _houseNumber;
  String _zip;
  String _city;
  String _country;

  Address(this._churchName, this._address1, this._houseNumber, this._zip,
      this._city, this._country);

  String get country => _country;

  String get city => _city;

  String get zip => _zip;

  String get houseNumber => _houseNumber;

  String get address1 => _address1;

  String get churchName => _churchName;

  String getZipAndCity() {
    return zip + ' ' + city;
  }
}
