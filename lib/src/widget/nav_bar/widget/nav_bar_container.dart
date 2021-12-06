import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/xayn_design.dart';

final _containerNotImplementedException =
    Exception('Did you forget to add $NavBarContainer?\n'
        'Please wrap your MaterialApp with $NavBarContainer');

const updateNabBarDebounceTimeout = Duration(milliseconds: 50);

class NavBarContainer extends StatefulWidget {
  final Widget child;

  const NavBarContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _NavBarContainerState createState() => _NavBarContainerState();

  /// Call this, when you need to update current instance of the [NavBar]
  /// f.e. [NavBarConfig] was changed for the screen
  static void updateNavBar(BuildContext context) {
    final typedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedNavBarContainer>();
    if (typedWidget == null) {
      throw _containerNotImplementedException;
    }
    return typedWidget.controller.updateNavBar();
  }

  /// This method used internally (from [NavBarObserver])
  /// Will initiate walk through the children widgets,
  /// find the latest instance of [NavBarConfig] and if it is not [null],
  /// then will draw [NavBar] with it.
  /// If not [NavBarConfig] found - [NavBar] will be not shown(removed)
  ///
  /// [goingBack] is a flag, that indicates that navigation flow going back.
  /// when [true], then will ignore latest [NavBarConfig] (from screen that will be removed)
  /// and will try to apply previous [NavBarConfig] (from screen that will be shown instead)
  static void resetNavBar(
    BuildContext context, {
    required bool goingBack,
  }) {
    final typedWidget =
        context.dependOnInheritedWidgetOfExactType<_InheritedNavBarContainer>();
    if (typedWidget == null) {
      throw _containerNotImplementedException;
    }
    return typedWidget.controller.resetNavBar(goingBack);
  }
}

class _NavBarContainerState extends State<NavBarContainer>
    implements _NavBarController {
  final resetStream = StreamController<bool?>();
  final updateStream = StreamController<bool?>();

  ConfigPair? _configPair;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    MergeStream([resetStream.stream, updateStream.stream])
        .debounceTime(updateNabBarDebounceTimeout)
        .listen((bool? goingBack) {
      _configPair ??= _getConfigPair(context, goingBack ?? false);
      _updateBar(_configPair!);
    });
    super.initState();
  }

  @override
  void dispose() async {
    await updateStream.close();
    await resetStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedNavBarContainer(controller: this, child: widget.child);

  @override
  void resetNavBar(bool goingBack) {
    _configPair = null;
    resetStream.add(goingBack);
  }

  @override
  void updateNavBar() => updateStream.add(null);

  void _updateBar(ConfigPair configPair) {
    for (final mixin in configPair.configMixins.reversed) {
      final config = mixin.navBarConfig;
      if (!config.type.isIgnored) {
        configPair.updater.update(config);
        return;
      }
    }
    configPair.updater.update(null);
  }

  ConfigPair _getConfigPair(
    BuildContext context,
    bool ignoreLast,
  ) {
    List<NavBarConfigMixin> list = [];
    ConfigUpdater? updater;
    void visitor(Element element) {
      if (element.widget is NavBar) {
        final widget = element as StatefulElement;
        if (updater != null) {
          throw Exception(
              'There can be only one $NavBar per $NavBarContainer, but found more.');
        }
        updater = widget.state as ConfigUpdater;
      } else if (element.widget is StatefulWidget) {
        final widget = element as StatefulElement;
        if (widget.state is NavBarConfigMixin) {
          final mixin = widget.state as NavBarConfigMixin;
          list.add(mixin);
        }
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    final navBarState = updater;
    if (navBarState == null) {
      throw Exception('Did you forget to add $NavBar?\n'
          'Please add with other children to $NavBarContainer');
    }

    if (ignoreLast && list.isNotEmpty) {
      list.removeLast();
    }
    return ConfigPair(navBarState, list);
  }
}

class _InheritedNavBarContainer extends InheritedWidget {
  final _NavBarController controller;

  const _InheritedNavBarContainer({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedNavBarContainer oldWidget) => false;
}

abstract class _NavBarController {
  /// Used internally, to find actual [NavBarConfigMixin]
  /// so it's [NavBarConfig] can be shown
  void resetNavBar(bool isGoingBack);

  /// [goingBack] needed, cos when
  /// - [Navigator.pop]
  /// - [Navigator.replace]
  /// - etc
  /// are called, then we need to ignore the latest [NavBarConfig],
  /// which is still part of the widget tree for some time
  void updateNavBar();
}
