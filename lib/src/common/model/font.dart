import 'package:skg_hagen/src/common/library/globals.dart';

class Font {
  double primarySize;
  double secondarySize;
  double iconSize;
  double boxSize;
  double imageIconSize;

  static const String PRIMARY_SIZE_NAME = 'standardFontSize';
  static const String SECONDARY_SIZE_NAME = 'secondaryFontSize';
  static const String ICON_SIZE_NAME = 'iconSize';
  static const String BOX_SIZE_NAME = 'boxSize';
  static const String IMAGE_ICON_SIZE_NAME = 'imageIconSize';
  static const double MAX = 6.0;
  static const double PRIMARY_SIZE = 2.5;
  static const double ICON_SIZE = 4.0;
  static const double SECONDARY_SIZE = 2.0;
  static const double BOX_SIZE = 22.5;
  static const double IMAGE_ICON_SIZE = 17.0;
  static const String NAME = 'Optima';

  Font() {
    primarySize = sharedPreferences.containsKey(PRIMARY_SIZE_NAME)
        ? sharedPreferences.getDouble(PRIMARY_SIZE_NAME)
        : PRIMARY_SIZE;
    secondarySize = sharedPreferences.containsKey(SECONDARY_SIZE_NAME)
        ? sharedPreferences.getDouble(SECONDARY_SIZE_NAME)
        : SECONDARY_SIZE;
    iconSize = sharedPreferences.containsKey(ICON_SIZE_NAME)
        ? sharedPreferences.getDouble(ICON_SIZE_NAME)
        : ICON_SIZE;
    boxSize = sharedPreferences.containsKey(BOX_SIZE_NAME)
        ? sharedPreferences.getDouble(BOX_SIZE_NAME)
        : BOX_SIZE;
    imageIconSize = sharedPreferences.containsKey(IMAGE_ICON_SIZE_NAME)
        ? sharedPreferences.getDouble(IMAGE_ICON_SIZE_NAME)
        : IMAGE_ICON_SIZE;
  }

  void increaseSize() {
    if (_canIncrease()) {
      primarySize = ++primarySize;
      secondarySize = ++secondarySize;
      iconSize = ++iconSize;
      boxSize = boxSize + ICON_SIZE;
      imageIconSize = imageIconSize + ICON_SIZE;
      _updateSharedPreferences();
    }
  }

  bool _canIncrease() => MAX > primarySize + 1;

  void decreaseSize() {
    if (_canDecrease()) {
      primarySize = --primarySize;
      secondarySize = --secondarySize;
      iconSize = --iconSize;
      boxSize = boxSize - ICON_SIZE;
      imageIconSize = imageIconSize - ICON_SIZE;
      _updateSharedPreferences();
    }
  }

  bool _canDecrease() => SECONDARY_SIZE < primarySize - 1;

  void _updateSharedPreferences() {
    sharedPreferences.setDouble(PRIMARY_SIZE_NAME, primarySize);
    sharedPreferences.setDouble(SECONDARY_SIZE_NAME, secondarySize);
    sharedPreferences.setDouble(ICON_SIZE_NAME, iconSize);
    sharedPreferences.setDouble(BOX_SIZE_NAME, boxSize);
  }

  bool isIncreaseMaximumReached() => !_canIncrease();

  bool isDecreaseMinimumReached() => !_canDecrease();
}
