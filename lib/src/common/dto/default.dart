import 'package:skg_hagen/src/common/dto/address.dart';

class Default {
  static const int COLOR_GREEN = 0xFF8EBC6B;
  static const int COLOR_DARKGREEN = 0xFF00976C;
  static const String NO_CONTENT = 'Aktuelles in Kürze';
  static const String COPIED = 'In die Zwischenablage kopiert!';
  static const String CALENDER = 'Kalender';
  static const String SHARE = 'Teilen';
  static const double SLIDE_ICON_SIZE = 4.0;
  static const double SLIDE_RATIO = 0.25;
  static const String SEND = 'Senden';

  static String capitalize(String value) =>
      value[0].toUpperCase() + value.substring(1);

  static String classNameFromRoute(String routeName) =>
      capitalize(routeName.substring(1));

  static String getSharableContent(String title,
      [String time, String comment, Address address]) {
    return "$title\n"
        "${time == null ? '' : time + '\n'}"
        "${comment == null || comment == '' ? '' : comment + '\n'}"
        "${address?.street == null ? '' : address.toString()}";
  }
}
