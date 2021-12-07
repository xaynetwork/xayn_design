import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_container.dart';

typedef _NavBarReset = Function(
  BuildContext context, {
  required bool goingBack,
});

class NavBarObserver extends NavigatorObserver {
  final _NavBarReset _navBarReset;

  NavBarObserver() : _navBarReset = NavBarContainer.resetNavBar;

  @visibleForTesting
  NavBarObserver.test(_NavBarReset navBarReset) : _navBarReset = navBarReset;

  @override
  void didPop(Route route, Route? previousRoute) {
    _resetNavBarConfig(true);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _resetNavBarConfig(false);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _resetNavBarConfig(false);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _resetNavBarConfig(false);
  }

  void _resetNavBarConfig(bool goingBack) {
    final context = navigator?.context;
    if (context == null) return;
    _navBarReset(context, goingBack: goingBack);
  }
}
