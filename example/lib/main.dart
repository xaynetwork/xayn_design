import 'package:example/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xayn_design/xayn_design.dart';

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
      home: MyHomePage(linden, onThemeChange),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
    this.linden,
    this.onThemeChange, {
    Key? key,
  }) : super(key: key);
  final Linden linden;
  final Function(Brightness) onThemeChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Linden get linden => widget.linden;
  bool get isDark => linden.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linden Example App'),
      ),
      body: ListView(
        children: [
          _buildHeadline('Icons'),
          _buildAssetsGrid(
            getIconAssets(linden),
            color: linden.colors.icon,
          ),
          SizedBox(height: linden.dimen.unit3),
          _buildHeadline('Graphics'),
          _buildAssetsGrid(
            getGraphicsAssets(linden),
            backgroundColor: linden.colors.iconDisabled,
          ),
          SizedBox(height: linden.dimen.unit3),
          _buildHeadline('Logos'),
          _buildAssetsGrid(getLogoAssets(linden)),
          SizedBox(height: linden.dimen.unit3),
          _buildHeadline('Illustrations'),
          _buildAssetsGrid(getIllustrationsAssets(linden)),
        ],
      ),
      floatingActionButton: _buildThemeTogglerButton(),
    );
  }

  Padding _buildHeadline(String str) => Padding(
        child: Text(str, style: linden.styles.appScreenHeadline),
        padding: EdgeInsets.only(bottom: linden.dimen.unit2),
      );

  FloatingActionButton _buildThemeTogglerButton() => FloatingActionButton(
        onPressed: () =>
            widget.onThemeChange(isDark ? Brightness.light : Brightness.dark),
        tooltip: 'Toggle Theme',
        child: SvgPicture.asset(
          isDark ? linden.assets.icons.sun : linden.assets.icons.moon,
          color: linden.colors.brightIcon,
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
