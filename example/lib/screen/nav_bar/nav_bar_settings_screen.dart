import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarSettingsScreen extends BaseNavBarScreen {
  static const routeName = '/navBarSettingsScreen';

  const NavBarSettingsScreen({Key? key}) : super(key: key);

  @override
  _NavBarSettingsScreenState createState() => _NavBarSettingsScreenState();
}

class _NavBarSettingsScreenState extends BaseNavBarScreenState<NavBarSettingsScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Settings screen';

  @override
  Color get screenBgColor => Colors.blue;

  @override
  NavBarConfig? get navBarConfig {
    final item = NavBarItemBackButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      key: back,
    );

    return NavBarConfig.backBtn(item);
  }
}
