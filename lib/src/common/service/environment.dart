import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Environment {
  static bool isProduction() {
    return bool.fromEnvironment('dart.vm.product');
  }

  static bool isiOS(BuildContext context){
    return Theme.of(context).platform == TargetPlatform.iOS;
  }
}
