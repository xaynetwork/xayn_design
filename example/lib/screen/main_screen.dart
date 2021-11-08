import 'package:example/screen/linden_screen.dart';
import 'package:example/screen/widgets_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _buildLindenBtn(),
        _buildWidgetsBtn(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Xayn Design Library')),
      body: content,
    );
  }

  Widget _buildLindenBtn() => _buildButton('Show Linden', () {
        _pushScreen(LindenScreen.routeName);
      });

  Widget _buildWidgetsBtn() => _buildButton('Show widgets', () {
        _pushScreen(WidgetsScreen.routeName);
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );

  void _pushScreen(String routeName) =>
      Navigator.of(context).pushNamed(routeName);
}