import 'package:example/screen/linden_screen.dart';
import 'package:example/screen/xayn_widgets/widgets_screen.dart';
import 'package:example/utils/tooltip_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xayn_design/xayn_design.dart';

import 'screen/main_screen.dart';

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
    );
    return MultiProvider(
      providers: _getProviders(),
      child: materialApp,
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
