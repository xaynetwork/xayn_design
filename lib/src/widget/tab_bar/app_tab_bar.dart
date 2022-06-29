import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/tab_bar/app_underline_tab_indicator.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

class AppTabBar extends StatelessWidget {
  final List<Widget> tabs;

  const AppTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    return TabBar(
      indicator: AppUnderlineTabIndicator(
        linden: linden,
        borderSide: BorderSide(
          width: linden.dimen.unit0_5,
          color: linden.colors.selectedItemBackgroundColor,
        ),
      ),
      indicatorColor: linden.colors.selectedItemBackgroundColor,
      labelStyle: linden.styles.mBoldStyle,
      labelColor: linden.colors.primaryText,
      isScrollable: true,
      unselectedLabelStyle: linden.styles.mStyle,
      unselectedLabelColor: linden.colors.secondaryText,
      tabs: tabs,
    );
  }
}
