import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarHomeScreen extends BaseNavBarScreen {
  static const routeName = '/navBarHomeScreen';

  const NavBarHomeScreen({Key? key}) : super(key: key);

  @override
  _NavBarHomeScreenState createState() => _NavBarHomeScreenState();
}

class _NavBarHomeScreenState extends BaseNavBarScreenState<NavBarHomeScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Home screen';

  @override
  Color get screenBgColor => Colors.orange;

  @override
  List<Widget> buildExtraChildren() => [
        buildBtn('Open reader mode', openReaderMode),
        buildBtn('Open onboarding screen', openOnboarding),
      ];

  @override
  NavBarConfig get navBarConfig => NavBarConfig([
        itemHome(isCurrent: true),
        itemSearch(),
        itemAccount(),
      ]);
}
