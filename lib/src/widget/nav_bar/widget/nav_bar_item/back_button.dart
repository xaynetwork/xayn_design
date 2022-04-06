import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class NavBarBackButton extends StatelessWidget {
  final NavBarItemBackButton data;

  const NavBarBackButton(this.data) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final icon = SvgPicture.asset(
      linden.assets.icons.arrowLeft,
      height: linden.dimen.iconSize,
      width: linden.dimen.iconSize,
      color: linden.colors.getNavBarIconColor(),
    );
    final btn = Material(
      child: InkWell(
        key: data.key,
        child: Center(child: icon),
        splashColor: linden.colors.splashColor,
        onTap: data.onPressed,
      ),
    );

    final radius = BorderRadius.circular(linden.dimen.unit6);
    final clipped = ClipRRect(
      child: btn,
      borderRadius: radius,
    );
    final sized = SizedBox(
      height: linden.dimen.buttonMinHeight,
      width: linden.dimen.buttonMinHeight,
      child: clipped,
    );
    final container = Container(
      child: sized,
      decoration: BoxDecoration(
        color: linden.colors.background,
        borderRadius: radius,
        boxShadow: [linden.styles.cardShadow],
      ),
    );

    return Padding(
      // should be 20*20 in the end of the day
      // 20 = 16 (default from nav_bar) + linden.dimen.unit0_5
      padding: EdgeInsets.all(linden.dimen.unit0_5),
      child: container,
    );
  }
}
