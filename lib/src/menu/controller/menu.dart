import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/service/featureFlag.dart';
import 'package:skg_hagen/src/menu/view/drawerList.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFeatureEnabled(FeatureFlag.KIRCHENJAHR),
      builder: (BuildContext context, AsyncSnapshot<dynamic> response) {
        if (response.connectionState == ConnectionState.done &&
            response.data != null) {
          return DrawerList.getList(context, response.data);
        }
        return Container();
      },
    );
  }

  Future<bool> _isFeatureEnabled(String featureName) async {
    return await FeatureFlag().isEnabled(featureName);
  }
}
