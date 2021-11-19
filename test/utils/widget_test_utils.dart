import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpAppWrapped(
    Widget widget, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) =>
      pumpWidget(appWrapped(widget));
}

Widget appWrapped(Widget child) {
  final linden = Linden();
  return UnterDenLinden(
    child: MaterialApp(
      theme: linden.themeData,
      home: child,
    ),
    initialLinden: linden,
  );
}
