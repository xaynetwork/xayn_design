import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'screen/linden_screen.dart';

void main() {
  final unterDenLinden = UnterDenLinden(
    child: const MyApp(),
    initialLinden: Linden(),
    onLindenUpdated: (final Linden newLinden) {
      print('Yay, linden was updated');
    },
  );

  runApp(unterDenLinden);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: UnterDenLinden.getLinden(context).themeData,
      home: const LindenScreen(),
    );
  }
}
