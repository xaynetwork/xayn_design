import 'package:example/screen/xayn_widgets/page/dots_indicator_page.dart';
import 'package:example/screen/xayn_widgets/page/switch_page.dart';
import 'package:example/screen/xayn_widgets/page/tooltip_page.dart';
import 'package:example/widget/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class WidgetsScreen extends StatefulWidget {
  static const routeName = '/widgets';

  const WidgetsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen>
    with TickerProviderStateMixin {
  final tabs = <String, Widget>{
    'Tooltip': const TooltipPage(),
    'Dots Indicator': const DotsIndicatorPage(),
    'Switch': const SwitchPage(),
  };

  late final TabController _tabController;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: Toolbar(
          title: 'Xayn widgets',
          bottom: _buildTabBar(),
        ),
        body: _buildTabBarView(),
      );

  TabBar _buildTabBar() => TabBar(
        controller: _tabController,
        labelStyle: linden.styles.appButtonTextInverse,
        indicatorColor: linden.colors.primary,
        isScrollable: true,
        tabs: tabs.keys.toList().map((e) => Tab(child: Text(e))).toList(),
      );

  TabBarView _buildTabBarView() => TabBarView(
        controller: _tabController,
        children: tabs.values.toList(),
      );
}
