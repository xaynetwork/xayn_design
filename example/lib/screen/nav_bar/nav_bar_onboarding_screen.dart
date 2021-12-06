import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarOnboardingScreen extends BaseNavBarScreen {
  static const routeName = '/navBarOnboardingScreen';

  const NavBarOnboardingScreen({Key? key}) : super(key: key);

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends BaseNavBarScreenState<NavBarOnboardingScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Onboarding screen';

  @override
  Color get screenBgColor => Colors.blue;

  @override
  NavBarConfig? get navBarConfig => NavBarConfig.hidden();

  @override
  List<Widget> buildExtraChildren() => [
        Text('It is possible to hide $NavBar for one of the nested screens.'),
      ];
}
