import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'screen/linden_screen.dart';

void main() {
  /// Instead of passing [Linden] as a parameter, it's better to injected it
  /// using your preferred state management package
  runApp(MyApp(Linden()));
}

class MyApp extends StatefulWidget {
  const MyApp(this.linden, {Key? key}) : super(key: key);
  final Linden linden;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Linden linden;

  @override
  void initState() {
    linden = widget.linden;
    super.initState();
  }

  onThemeChange(Brightness brightness) {
    setState(() {
      linden = linden.updateBrightness(brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: linden.themeData,
      home: LindenScreen(linden, onThemeChange),
    );
  }
}
