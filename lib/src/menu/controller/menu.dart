import 'package:flutter/material.dart';
import 'package:skg_hagen/src/menu/view/drawerList.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerList.getList(context);
  }
}