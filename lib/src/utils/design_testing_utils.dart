import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

/// Helper extension functions for making testing easier for apps that use
/// Linden
extension XaynDesignWidgetTesterExtension on WidgetTester {
  Future<void> pumpLindenApp(
    Widget widget, {
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
    Linden? initialLinden,
    ThemeData? theme,
    List<NavigatorObserver>? observers,
    bool withNavBarContainer = false,
  }) {
    final child =
        withNavBarContainer ? _appWrappedWithNavBarContainer(widget) : widget;
    final withLinden = _appWrappedWithLinden(
      child: child,
      initialLinden: initialLinden,
      theme: theme,
      observers: observers,
    );
    return pumpWidget(
      withLinden,
      duration,
      phase,
    );
  }
}

Widget _appWrappedWithLinden({
  required Widget child,
  Linden? initialLinden,
  ThemeData? theme,
  List<NavigatorObserver>? observers,
}) {
  final linden = initialLinden ?? Linden();
  return UnterDenLinden(
    child: MaterialApp(
      theme: theme ?? linden.themeData,
      home: child,
      navigatorObservers: observers ?? [],
    ),
    initialLinden: linden,
  );
}

Widget _appWrappedWithNavBarContainer(Widget child) => NavBarContainer(
      child: Stack(
        children: [
          Positioned.fill(child: child),
          const Positioned.fill(top: null, child: NavBar())
        ],
      ),
    );

/// Can be used, when you need to find an element `byType` with the generic
Type typeOf<T>() => T;
