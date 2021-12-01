import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';
import 'package:xayn_design/xayn_design.dart';

class NavBarIconButton extends StatelessWidget {
  final NavBarItemIconButton data;

  const NavBarIconButton(this.data) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final icon = SvgPicture.asset(
      data.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.iconNew,
    );
    final btn = InkWell(
      key: data.key,
      onTap: data.onPressed,
      child: Center(child: icon),
      borderRadius: BorderRadius.circular(linden.dimen.unit),
    );

    return SizedBox(
      width: linden.dimen.navBarItemHeight,
      height: linden.dimen.navBarItemHeight,
      child: Center(
        child: SizedBox(
          child: btn,
          height: linden.dimen.navBarSelectableHeight,
          width: linden.dimen.navBarSelectableHeight,
        ),
      ),
      // child: Padding(
      //   padding: EdgeInsets.all(linden.dimen.unit0_25),
      //   child: btn,
      // ),
    );
  }
}