import 'package:example/screen/linden_screen.dart';
import 'package:example/screen/main_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_account_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_home_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_ignored_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_onboarding_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_reader_node_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_search_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_settings_screen.dart';
import 'package:example/screen/xayn_widgets/widgets_screen.dart';
import 'package:example/utils/tooltip_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  final unterDenLinden = UnterDenLinden(
    child: MyApp(),
    initialLinden: Linden(),
    onLindenUpdated: (final Linden newLinden) {
      //ignore: avoid_print
      print('Yay, linden was updated');
    },
  );

  runApp(unterDenLinden);
}

class MyApp extends StatelessWidget {
  final _tooltipController = TooltipController();
  final _applicationTooltipController = ApplicationTooltipController();

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: 'Flutter Demo',
      theme: UnterDenLinden.getLinden(context).themeData,
      onGenerateRoute: createCupertinoPageRoute,
      navigatorObservers: [NavBarObserver()],
    );

    final stack = Stack(
      children: [
        materialApp,
        const Positioned.fill(top: null, child: NavBar()),
      ],
    );

    // this one used to style properly NavBar components
    // it should be the same as your App class
    final root = MaterialApp(
      home: NavBarContainer(child: stack),
      theme: materialApp.theme,
    );

    return MultiProvider(
      providers: _getProviders(),
      child: root,
    );
  }

  List<SingleChildWidget> _getProviders() => [
        ChangeNotifierProvider<TooltipController>.value(
            value: _tooltipController),
        Provider<ApplicationTooltipController>.value(
            value: _applicationTooltipController),
      ];

  PageRoute? createCupertinoPageRoute(RouteSettings routeSettings) {
    late final Widget? screenWidget;
    switch (routeSettings.name) {
      case MainScreen.routeName:
        screenWidget = const MainScreen();
        break;
      case LindenScreen.routeName:
        screenWidget = const LindenScreen();
        break;
      case WidgetsScreen.routeName:
        screenWidget = const WidgetsScreen();
        break;
      case NavBarHomeScreen.routeName:
        screenWidget = const NavBarHomeScreen();
        break;
      case NavBarAccountScreen.routeName:
        screenWidget = const NavBarAccountScreen();
        break;
      case NavBarSearchScreen.routeName:
        screenWidget = const NavBarSearchScreen();
        break;
      case NavBarOnboardingScreen.routeName:
        screenWidget = const NavBarOnboardingScreen();
        break;
      case NavBarSettingsScreen.routeName:
        screenWidget = const NavBarSettingsScreen();
        break;
      case NavBarReaderModeScreen.routeName:
        screenWidget = const NavBarReaderModeScreen();
        break;
      case NavBarIgnoredScreen.routeName:
        screenWidget = const NavBarIgnoredScreen();
        break;
      default:
        screenWidget = null;
    }

    if (screenWidget == null) {
      return null;
    }
    return CupertinoPageRoute(
      builder: (_) => ApplicationTooltipProvider(
        messageFactory: TooltipMessageProvider.of(),
        child: screenWidget!,
      ),
      settings: routeSettings,
    );
  }
}
