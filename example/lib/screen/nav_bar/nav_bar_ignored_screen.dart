import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarIgnoredScreen extends BaseNavBarScreen {
  static const routeName = '/navBarIgnoredScreen';

  const NavBarIgnoredScreen({Key? key}) : super(key: key);

  @override
  _NavBarIgnoredScreenState createState() => _NavBarIgnoredScreenState();
}

class _NavBarIgnoredScreenState
    extends BaseNavBarScreenState<NavBarIgnoredScreen> with NavBarConfigMixin {
  @override
  String get screenTitle => 'Ignored screen';

  @override
  Color get screenBgColor => Colors.blue;

  bool isIgnored = true;

  @override
  List<Widget> buildExtraChildren() {
    final title = Text(
      'At this screen configs CAN BE ignored and then previous [$NavBarConfig] will be applied',
      textAlign: TextAlign.center,
    );
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Ignore current screen config'),
        const SizedBox(width: 42),
        AppSwitchWidget(
            value: isIgnored,
            onToggle: (isIgnored) {
              setState(
                () {
                  this.isIgnored = isIgnored;
                  NavBarContainer.updateNavBar(context);
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
  NavBarConfig get navBarConfig => isIgnored
      ? NavBarConfig.ignored()
      : NavBarConfig.backBtn(NavBarItemBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          key: back,
        ));
}
