import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/xayn_design.dart';

final _containerNotImplementedException =
    Exception('Did you forget to add $NavBarContainer?\n'
        'Please wrap your MaterialApp with $NavBarContainer');

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
  late ConfigPair _configPair;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  Widget build(BuildContext context) =>
      _InheritedNavBarContainer(controller: this, child: widget.child);

  @override
  void resetNavBar(bool goingBack) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      _configPair = _getNavBarConfigPairToShow(context, goingBack);
      _updateBar();
    });
  }

  @override
  void updateNavBar() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      _updateBar();
    });
  }

  void _updateBar() {
    final config = _configPair.configMixin?.navBarConfig;
    _configPair.updater.update(config);
  }

  ConfigPair _getNavBarConfigPairToShow(
    BuildContext context,
    bool ignoreLast,
  ) {
    NavBarConfigMixin? preLastMixin;
    NavBarConfigMixin? lastMixin;
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
          preLastMixin = lastMixin;
          lastMixin = mixin;
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
    final mixin = ignoreLast ? preLastMixin : lastMixin;
    return ConfigPair(navBarState, mixin);
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
  void resetNavBar(bool isGoingBack);

  /// [goingBack] needed, cos when
  /// - [Navigator.pop]
  /// - [Navigator.replace]
  /// - etc
  /// are called, then we need to ignore the latest [NavBarConfig],
  /// which is still part of the widget tree for some time
  void updateNavBar();
}
