import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import '../resources.dart';

class LindenScreen extends StatefulWidget {
  static const routeName = '/linden';

  const LindenScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LindenScreen> createState() => _LindenScreenState();
}

class _LindenScreenState extends State<LindenScreen> {
  Linden get linden => UnterDenLinden.getLinden(context);

  bool get isDark => linden.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xayn Linden'),
      ),
      body: _buildListView(),
      floatingActionButton: _buildThemeTogglerButton(),
    );
  }

  ListView _buildListView() => ListView(
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
      );

  Padding _buildHeadline(String str) => Padding(
        child: Text(str, style: linden.styles.appScreenHeadline),
        padding: EdgeInsets.only(bottom: linden.dimen.unit2),
      );

  FloatingActionButton _buildThemeTogglerButton() => FloatingActionButton(
        onPressed: () {
          final brightness = isDark ? Brightness.light : Brightness.dark;
          UnterDenLinden.of(context).changeBrightness(brightness);
        },
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
