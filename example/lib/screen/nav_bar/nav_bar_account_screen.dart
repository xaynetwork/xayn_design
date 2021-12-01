import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarAccountScreen extends BaseNavBarScreen {
  static const routeName = '/navBarAccountScreen';

  const NavBarAccountScreen({Key? key}) : super(key: key);

  @override
  _NavBarHomeScreenState createState() => _NavBarHomeScreenState();
}

class _NavBarHomeScreenState extends BaseNavBarScreenState<NavBarAccountScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Account screen';

  @override
  Color get screenBgColor => Colors.pinkAccent;

  @override
  List<Widget> buildExtraChildren() => [
        buildBtn('Open settings', openSettings),
      ];

  @override
  NavBarConfig get navBarConfig => NavBarConfig([
        itemHome(),
        itemSearch(),
        itemAccount(isCurrent: true),
      ]);
}
