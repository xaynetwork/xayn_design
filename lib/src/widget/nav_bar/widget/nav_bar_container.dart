import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/xayn_design.dart';

const updateNavBarDebounceTimeout = Duration(milliseconds: 50);

class NavBarContainer extends StatefulWidget {
  final Widget child;
  final GlobalKey globalKey;

  NavBarContainer({
    GlobalKey? key,
    required this.child,
  })  : globalKey = key ?? GlobalKey(),
        super(key: key);

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

  /// Call this, when you need the position of the [NavBar]
  static Offset? getNavBarPosition(BuildContext context) {
    if (!staticCallsEnabled) return null;
    return _getTypedWidget(context).controller.getNavBarPosition();
  }

  /// Call this, when you need to know if the [NavBar] is visible
  static bool isNavBarVisible(BuildContext context) {
    if (!staticCallsEnabled) return false;
    return _getTypedWidget(context).controller.isNavBarVisible();
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
  late final StreamSubscription<bool?> _streamSubscription;

  ConfigPair? configPair;
  NavBarConfigMixin? currentNavBarConfigMixin;

  Linden get linden => UnterDenLinden.getLinden(context);

  var _isVisible = true;

  @override
  void initState() {
    final isInTest = Platform.environment.containsKey('FLUTTER_TEST');
    final timeout = isInTest ? const Duration() : updateNavBarDebounceTimeout;
    final stream = MergeStream([resetStream.stream, updateStream.stream])
        .debounceTime(timeout);

    _streamSubscription = stream.listen((goingBack) {
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
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InheritedNavBarContainer(
        key: widget.globalKey,
        controller: this,
        child: widget.child,
      );

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
  bool isNavBarVisible() => _isVisible;

  @override
  void hideNavBar() {
    if (!_isVisible) return;
    _tryToUpdateVisibility(false);
  }

  @override
  void showNavBar() {
    if (_isVisible) return;
    _tryToUpdateVisibility(true);
  }

  @override
  Offset? getNavBarPosition() {
    final currentContext = widget.globalKey.currentContext;
    if (currentContext == null) return null;
    final renderBox = currentContext.findRenderObject() as RenderBox;
    final offset = renderBox.globalToLocal(Offset.zero);
    return offset;
  }

  void _updateBar(ConfigPair configPair) {
    if (!_isVisible) {
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
        list.last.navBarConfig.id ==
            currentNavBarConfigMixin?.navBarConfig.id) {
      list.removeLast();
    }
    return ConfigPair(navBarState, list);
  }

  void _tryToUpdateVisibility(bool isVisible) {
    _isVisible = isVisible;
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

  /// Used internally, to get if nav bar is visible
  bool isNavBarVisible();

  Offset? getNavBarPosition();
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
