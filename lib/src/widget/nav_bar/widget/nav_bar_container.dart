import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/xayn_design.dart';

const updateNavBarDebounceTimeout = Duration(milliseconds: 50);

class NavBarContainer extends StatefulWidget {
  final Widget child;

  const NavBarContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  NavBarContainerState createState() => NavBarContainerState();

  /// Call this, when you need to update current instance of the [NavBar]
  /// f.e. [NavBarConfig] was changed for the screen
  static void updateNavBar(BuildContext context) {
    if (!staticCallsEnabled) return;
    return _getTypedWidget(context).controller.updateNavBar();
  }

  /// Call this, when you need to hide the [NavBar]
  static void hideNavBar(BuildContext context) {
    if (!staticCallsEnabled) return;
    return _getTypedWidget(context).controller.hideNavBar();
  }

  /// Call this, when you need to show the [NavBar]
  static void showNavBar(BuildContext context) {
    if (!staticCallsEnabled) return;
    return _getTypedWidget(context).controller.showNavBar();
  }

  static InheritedNavBarContainer _getTypedWidget(BuildContext context) {
    final typedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedNavBarContainer>();
    if (typedWidget == null) {
      throw const NavBarContainerNotFoundException();
    }
    return typedWidget;
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
    if (!staticCallsEnabled) return;
    final typedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedNavBarContainer>();
    if (typedWidget == null) {
      throw const NavBarContainerNotFoundException();
    }
    return typedWidget.controller.resetNavBar(goingBack);
  }

  /// We need disable [resetNavBar] && [updateNavBar] methods call,
  /// to be able properly test [NavBar]
  @visibleForTesting
  static bool staticCallsEnabled = true;
}

class NavBarContainerState extends State<NavBarContainer>
    implements NavBarController {
  final resetStream = StreamController<bool?>();
  final updateStream = StreamController<bool?>();

  ConfigPair? configPair;
  NavBarConfigMixin? currentNavBarConfigMixin;

  Linden get linden => UnterDenLinden.getLinden(context);

  var isVisible = true;

  @override
  void initState() {
    MergeStream([resetStream.stream, updateStream.stream])
        .debounceTime(updateNavBarDebounceTimeout)
        .listen((bool? goingBack) {
      if (!mounted) return;
      configPair ??= _getConfigPair(context, goingBack ?? false);
      _updateBar(configPair!);
    });

    super.initState();
  }

  @override
  void dispose() {
    updateStream.close();
    resetStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      InheritedNavBarContainer(controller: this, child: widget.child);

  @override
  void resetNavBar(bool goingBack) {
    if (resetStream.isClosed) return;
    configPair = null;
    resetStream.add(goingBack);
  }

  @override
  void updateNavBar() {
    if (updateStream.isClosed) return;
    updateStream.add(null);
  }

  @override
  void hideNavBar() => _tryToUpdateVisibility(false);

  @override
  void showNavBar() => _tryToUpdateVisibility(true);

  void _updateBar(ConfigPair configPair) {
    if (!isVisible) {
      configPair.updater.update(NavBarConfig.hidden());
      return;
    }

    for (final mixin in configPair.configMixins.reversed) {
      final config = mixin.navBarConfig;
      if (!config.type.isIgnored) {
        configPair.updater.update(config);
        currentNavBarConfigMixin = mixin;
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
          throw const ToManyNavBarFoundException();
        }
        updater = widget.state as ConfigUpdater;
      } else if (element.widget is StatelessWidget) {
        if (element.widget is NavBarConfigMixin) {
          final mixin = element.widget as NavBarConfigMixin;
          list.add(mixin);
        }
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
      throw const NavBarNotFoundException();
    }

    if (ignoreLast &&
        list.isNotEmpty &&
        list.last.runtimeType == currentNavBarConfigMixin.runtimeType) {
      list.removeLast();
    }
    return ConfigPair(navBarState, list);
  }

  void _tryToUpdateVisibility(bool isVisible) {
    this.isVisible = isVisible;
    final pair = configPair;
    if (pair == null) return;
    _updateBar(pair);
  }
}

class InheritedNavBarContainer extends InheritedWidget {
  final NavBarController controller;

  const InheritedNavBarContainer({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedNavBarContainer oldWidget) => false;
}

abstract class NavBarController {
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

  /// Used internally, to update [NavBarConfig] to [NavBarConfig.hidden]
  void hideNavBar();

  /// Used internally, to get the last non hidden config
  void showNavBar();
}

class NavBarContainerNotFoundException implements Exception {
  const NavBarContainerNotFoundException();

  @override
  String toString() => 'Did you forget to add $NavBarContainer?\n'
      'Please wrap your MaterialApp with $NavBarContainer';
}

class NavBarNotFoundException implements Exception {
  const NavBarNotFoundException();

  @override
  String toString() => 'Did you forget to add $NavBar?\n'
      'Please add with other children to $NavBarContainer';
}

class ToManyNavBarFoundException implements Exception {
  const ToManyNavBarFoundException();

  @override
  String toString() =>
      'There can be only one $NavBar per $NavBarContainer, but found more.';
}
