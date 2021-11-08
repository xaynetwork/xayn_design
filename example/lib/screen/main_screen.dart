import 'package:example/screen/linden_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
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
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Xayn Design Library')),
      body: content,
    );
  }

  Widget _buildLindenBtn() => _buildButton('Show Linden', () {
        _pushScreen(const LindenScreen());
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );

  void _pushScreen(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}
