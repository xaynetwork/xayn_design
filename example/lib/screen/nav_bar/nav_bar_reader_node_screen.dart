import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'base_nav_bar_screen.dart';

class NavBarReaderModeScreen extends BaseNavBarScreen {
  static const routeName = '/navBarReaderModeScreen';

  const NavBarReaderModeScreen({Key? key}) : super(key: key);

  @override
  _NavBarReaderModeScreenState createState() => _NavBarReaderModeScreenState();
}

class _NavBarReaderModeScreenState
    extends BaseNavBarScreenState<NavBarReaderModeScreen>
    with NavBarConfigMixin {
  @override
  String get screenTitle => 'Reader mode screen';

  @override
  Color get screenBgColor => Colors.deepPurpleAccent;

  bool? isLiked;

  @override
  NavBarConfig? get navBarConfig {
    final goBack = NavBarItemIconButton(
      svgIconPath: linden.assets.icons.arrowLeft,
      isHighlighted: false,
      onPressed: () {
        Navigator.of(context).pop();
      },
      key: back,
    );

    final like = NavBarItemIconButton(
      svgIconPath: isLiked == true
          ? linden.assets.icons.thumbsUpActive
          : linden.assets.icons.thumbsUp,
      isHighlighted: false,
      onPressed: () {
        if (isLiked == null || isLiked == false) {
          isLiked = true;
        } else if (isLiked == true) {
          isLiked = null;
        }
        NavBarContainer.updateNavBar(context);
      },
      key: keyLike,
    );
    final dislike = NavBarItemIconButton(
      svgIconPath: isLiked == false
          ? linden.assets.icons.thumbsDownActive
          : linden.assets.icons.thumbsDown,
      isHighlighted: false,
      onPressed: () {
        if (isLiked == null || isLiked == true) {
          isLiked = false;
        } else if (isLiked == false) {
          isLiked = null;
        }
        NavBarContainer.updateNavBar(context);
      },
      key: keyDisLike,
    );
    final share = NavBarItemIconButton(
      svgIconPath: linden.assets.icons.share,
      isHighlighted: false,
      onPressed: () {},
      key: keyShare,
    );

    return NavBarConfig([
      goBack,
      like,
      dislike,
      share,
    ], isWidthExpanded: true);
  }
}
