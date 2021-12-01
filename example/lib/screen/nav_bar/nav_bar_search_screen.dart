import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarSearchScreen extends BaseNavBarScreen {
  static const routeName = '/navBarSearchScreen';

  const NavBarSearchScreen({Key? key}) : super(key: key);

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends BaseNavBarScreenState<NavBarSearchScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Search screen';

  @override
  Color get screenBgColor => Colors.greenAccent;

  @override
  NavBarConfig get navBarConfig {
    final search = NavBarItemEdit(
      svgIconPath: linden.assets.icons.search,
      isHighlighted: true,
      onSearchPressed: (final String text) {
        //ignore: avoid_print
        print('SEARCH SCREEN: onSubmitted: $text');
      },
      onTextChanged: (final String text) {
        //ignore: avoid_print
        print('SEARCH SCREEN: onTextChanged: $text');
      },
      autofocus: true,
      key: keySearch,
      initialText: Random().nextBool() ? null : 'Initial (random)',
      hint: Random().nextBool() ? null : 'Hint (random)',
    );

    return NavBarConfig([
      itemHome(),
      search,
      itemAccount(),
    ]);
  }
}
