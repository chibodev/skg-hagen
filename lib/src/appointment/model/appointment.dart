import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skg_hagen/src/common/model/address.dart';

class Appointment {
  String _title;
  DateTime _dateAndTime;
  Address _address;
  String _organizer;

  Appointment(this._title, this._dateAndTime, this._address, [this._organizer]);

  String get title => _title;

  DateTime get dateAndTime => _dateAndTime;

  String get organizer => _organizer;

  Address get address => _address;

  String getFormattedTime() {
    initializeDateFormatting('de_DE', null);
    return DateFormat("E d.M.yy | HH:mm", "de_DE").format(dateAndTime).toString().toUpperCase();
  }
}
