import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarHiddenScreen extends BaseNavBarScreen {
  static const routeName = '/navBarHiddenScreen';

  const NavBarHiddenScreen({Key? key}) : super(key: key);

  @override
  _NavBarIgnoredScreenState createState() => _NavBarIgnoredScreenState();
}

class _NavBarIgnoredScreenState
    extends BaseNavBarScreenState<NavBarHiddenScreen> with NavBarConfigMixin {
  @override
  String get screenTitle => 'Hidden screen';

  @override
  Color get screenBgColor => Colors.blue;

  bool isHidden = false;

  @override
  List<Widget> buildExtraChildren() {
    const title = Text(
      'At this screen configs CAN BE hidden',
      textAlign: TextAlign.center,
    );
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hide current navbar screen'),
        const SizedBox(width: 42),
        AppSwitchWidget(
            value: isHidden,
            onToggle: (isHidden) {
              setState(
                () {
                  this.isHidden = isHidden;
                  if (isHidden) {
                    NavBarContainer.hideNavBar(context);
                  } else {
                    NavBarContainer.showNavBar(context);
                  }
                },
              );
            })
      ],
    );
    return [
      title,
      const SizedBox(height: 42),
      row,
    ];
  }

  @override
  NavBarConfig get navBarConfig => NavBarConfig([
        itemHome(isCurrent: true),
        itemSearch(),
        itemAccount(),
      ]);
}
