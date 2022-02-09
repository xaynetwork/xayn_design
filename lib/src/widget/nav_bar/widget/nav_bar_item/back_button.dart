import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class NavBarBackButton extends StatelessWidget {
  final NavBarItemBackButton data;

  const NavBarBackButton(this.data) : super(key: null);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final fab = FloatingActionButton.large(
      key: data.key,
      backgroundColor: linden.colors.primaryAction,
      elevation: 0,
      onPressed: data.onPressed,
      child: SvgPicture.asset(
        linden.assets.icons.arrowLeft,
        color: linden.colors.iconInverse,
      ),
      heroTag: null,
    );
    final sized = SizedBox(
      height: linden.dimen.buttonMinHeight,
      width: linden.dimen.buttonMinHeight,
      child: fab,
    );
    return Padding(
      // should be 20*20 in the end of the day
      // 20 = 16 (default from nav_bar) + linden.dimen.unit0_5
      padding: EdgeInsets.all(linden.dimen.unit0_5),
      child: sized,
    );
  }
}
