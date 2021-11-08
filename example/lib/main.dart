import 'package:example/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  /// Instead of passing [Linden] as a parameter, it's better to injected it
  /// using your preferred state management package
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  onThemeChange(Brightness brightness) {
    setState(() {
      Linden.updateBrightness(brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Linden.themeData,
      home: MyHomePage(onThemeChange),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
    this.onThemeChange, {
    Key? key,
  }) : super(key: key);
  final Function(Brightness) onThemeChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool get isDark => Linden.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xayn Design Library (Linden)'),
      ),
      body: _buildListView(),
      floatingActionButton: _buildThemeTogglerButton(),
    );
  }

  ListView _buildListView() => ListView(
        children: [
          _buildHeadline('Icons'),
          _buildAssetsGrid(
            getIconAssets(),
            color: Linden.colors.icon,
          ),
          SizedBox(height: Linden.dimen.unit3),
          _buildHeadline('Graphics'),
          _buildAssetsGrid(
            getGraphicsAssets(),
            backgroundColor: Linden.colors.iconDisabled,
          ),
          SizedBox(height: Linden.dimen.unit3),
          _buildHeadline('Logos'),
          _buildAssetsGrid(getLogoAssets()),
          SizedBox(height: Linden.dimen.unit3),
          _buildHeadline('Illustrations'),
          _buildAssetsGrid(getIllustrationsAssets()),
        ],
      );

  Padding _buildHeadline(String str) => Padding(
        child: Text(str, style: Linden.styles.appScreenHeadline),
        padding: EdgeInsets.only(bottom: Linden.dimen.unit2),
      );

  FloatingActionButton _buildThemeTogglerButton() => FloatingActionButton(
        onPressed: () =>
            widget.onThemeChange(isDark ? Brightness.light : Brightness.dark),
        tooltip: 'Toggle Theme',
        child: SvgPicture.asset(
          isDark ? Linden.assets.icons.sun : Linden.assets.icons.moon,
          color: Linden.colors.brightIcon,
        ),
      );

  GridView _buildAssetsGrid(
    List<String> icons, {
    Color? color,
    Color? backgroundColor,
  }) =>
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50,
          crossAxisSpacing: 5,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Container(
            color: backgroundColor,
            child: SvgPicture.asset(
              icons[index],
              color: color,
            ),
          );
        },
      );
}
