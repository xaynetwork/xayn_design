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
        (_) => Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom +
              linden.dimen.bottomBarDockedHeight +
              linden.dimen.unit,
          right: linden.dimen.unit2,
          width: linden.dimen.unit10,
          child: _buildMenu(),
        ),
      ),
      key: keyShare,
    );

    return NavBarConfig([
      goBack,
      like,
      dislike,
      share,
      menu,
    ], isWidthExpanded: true);
  }

  Widget _buildMenu() => ClipRRect(
        borderRadius: linden.styles.roundBorder,
        child: ColoredBox(
          color: linden.colors.cardBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(linden.dimen.unit),
                child: Text(
                  'Item 1',
                  style: linden.styles.appSmallHeadlineText,
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(linden.dimen.unit),
                child: Text(
                  'Item 2',
                  style: linden.styles.appSmallHeadlineText,
                ),
              ),
            ],
          ),
        ),
      );
}
