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
    with NavBarConfigMixin, OverlayStateMixin {
  @override
  String get screenTitle => 'Reader mode screen';

  @override
  Color get screenBgColor => Colors.deepPurpleAccent;

  bool? isLiked;

  @override
  NavBarConfig get navBarConfig {
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

    final menu = NavBarItemIconButton(
      svgIconPath: linden.assets.icons.menu,
      isHighlighted: false,
      onPressed: () => toggleOverlay(
        (_) => AppMenu(
          bottom: MediaQuery.of(context).viewInsets.bottom +
              linden.dimen.bottomBarDockedHeight +
              linden.dimen.unit4_25,
          end: linden.dimen.unit2,
          width: linden.dimen.unit15,
          children: getMenuList,
        ),
      ),
      key: keyShare,
    );

    return NavBarConfig(navBarId, [
      goBack,
      like,
      dislike,
      share,
      menu,
    ], isWidthExpanded: true);
  }

  List<Widget> get getMenuList => List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.all(linden.dimen.unit),
          child: Center(
            child: Text(
              'Item $index',
              style: linden.styles.mBoldStyle,
            ),
          ),
        ),
      );
}
