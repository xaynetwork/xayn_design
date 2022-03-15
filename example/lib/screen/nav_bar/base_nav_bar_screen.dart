import 'package:example/screen/nav_bar/nav_bar_account_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_hidden_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_home_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_ignored_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_onboarding_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_reader_node_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_search_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_settings_screen.dart';
import 'package:example/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const back = Key('back');
const keyHome = Key('home');
const keySearch = Key('search');
const keyPerson = Key('person');
const keyLike = Key('like');
const keyDisLike = Key('dis_like');
const keyShare = Key('share');

abstract class BaseNavBarScreen extends StatefulWidget {
  const BaseNavBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  BaseNavBarScreenState createState();
}

abstract class BaseNavBarScreenState<T extends BaseNavBarScreen>
    extends State<T> with NavBarConfigMixin {
  late final navBarId = NavBarConfigId(runtimeType.toString());

  Linden get linden => UnterDenLinden.getLinden(context);

  String get screenTitle;

  Color get screenBgColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: screenBgColor,
        appBar: Toolbar(title: screenTitle),
        body: _buildBody(),
      );

  List<Widget> buildExtraChildren() => [];

  Widget _buildBody() => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('This is a screen simulation to show NavBar cases'),
          const SizedBox(height: 42),
          Text(
            'This is $screenTitle',
            style: UnterDenLinden.getLinden(context).styles.xlBoldStyle,
          ),
          const SizedBox(height: 42),
          ...buildExtraChildren(),
        ],
      ));

  void _replaceScreen(String route) =>
      Navigator.of(context).pushReplacementNamed(route);

  void _push(String route) => Navigator.of(context).pushNamed(route);

  void replaceSearch() => _replaceScreen(NavBarSearchScreen.routeName);

  void replaceAccount() => _replaceScreen(NavBarAccountScreen.routeName);

  void replaceHome() => _replaceScreen(NavBarHomeScreen.routeName);

  void openSettings() => _push(NavBarSettingsScreen.routeName);

  void openReaderMode() => _push(NavBarReaderModeScreen.routeName);

  void openOnboarding() => _push(NavBarOnboardingScreen.routeName);

  void openIgnored() => _push(NavBarIgnoredScreen.routeName);

  void openHidden() => _push(NavBarHiddenScreen.routeName);

  Widget buildBtn(String title, VoidCallback onPressed) =>
      AppRaisedButton.text(onPressed: onPressed, text: title);

  //region items
  NavBarItem itemSearch() => NavBarItemIconButton(
        svgIconPath: linden.assets.icons.search,
        isHighlighted: false,
        onPressed: replaceSearch,
        key: keySearch,
      );

  NavBarItem itemHome({bool isCurrent = false}) => NavBarItemIconButton(
        svgIconPath: linden.assets.icons.home,
        isHighlighted: isCurrent,
        onPressed: isCurrent ? () {} : replaceHome,
        key: keyHome,
      );

  NavBarItem itemAccount({bool isCurrent = false}) => NavBarItemIconButton(
        svgIconPath: linden.assets.icons.person,
        isHighlighted: isCurrent,
        onPressed: isCurrent ? () {} : replaceAccount,
        key: keyPerson,
      );
//endregion items
}
