import 'package:skg_hagen/src/common/library/globals.dart';

class Font {
  double primarySize;
  double secondarySize;
  static const String PRIMARY_SIZE_NAME = 'standardFontSize';
  static const String SECONDARY_SIZE_NAME = 'secondaryFontSize';
  static const double MAX = 6.0;
  static const double PRIMARY_SIZE = 2.5;
  static const double SECONDARY_SIZE = 2.0;
  static const String NAME = 'Optima';

  Font() {
    primarySize = sharedPreferences.containsKey(PRIMARY_SIZE_NAME)
        ? sharedPreferences.getDouble(PRIMARY_SIZE_NAME)
        : PRIMARY_SIZE;
    secondarySize = sharedPreferences.containsKey(SECONDARY_SIZE_NAME)
        ? sharedPreferences.getDouble(SECONDARY_SIZE_NAME)
        : SECONDARY_SIZE;
  }

  void increaseSize() {
    if (MAX > primarySize + 1) {
      primarySize = ++primarySize;
      secondarySize = ++secondarySize;
      _updateSharedPreferences();
    }
  }

  void decreaseSize() {
    if (SECONDARY_SIZE < primarySize - 1) {
      primarySize = --primarySize;
      secondarySize = --secondarySize;
      _updateSharedPreferences();
    }
  }

  void _updateSharedPreferences() {
    sharedPreferences.setDouble(PRIMARY_SIZE_NAME, primarySize);
    sharedPreferences.setDouble(SECONDARY_SIZE_NAME, secondarySize);
  }
}
