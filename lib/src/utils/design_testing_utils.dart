import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/linden/linden.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

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
  }) =>
      pumpWidget(
        _appWrappedWithLinden(
          child: widget,
          initialLinden: initialLinden,
          theme: theme,
          observers: observers,
        ),
        duration,
        phase,
      );
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

/// Can be used, when you need to find an element `byType` with the generic
Type typeOf<T>() => T;
