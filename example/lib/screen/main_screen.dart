import 'package:example/screen/linden_screen.dart';
import 'package:example/screen/nav_bar/nav_bar_home_screen.dart';
import 'package:example/screen/xayn_widgets/widgets_screen.dart';
import 'package:example/widget/toolbar.dart';
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
        _buildNavBarBtn(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
    return Scaffold(
      appBar: const Toolbar(title: 'Xayn Design Library'),
      body: content,
    );
  }

  Widget _buildLindenBtn() => _buildButton('Show Linden', () {
        _pushScreen(LindenScreen.routeName);
      });

  Widget _buildWidgetsBtn() => _buildButton('Show xayn widgets', () {
        _pushScreen(WidgetsScreen.routeName);
      });

  Widget _buildNavBarBtn() => _buildButton('Show NavBar', () {
        _pushScreen(NavBarHomeScreen.routeName);
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );

  void _pushScreen(String routeName) =>
      Navigator.of(context).pushNamed(routeName);
}
