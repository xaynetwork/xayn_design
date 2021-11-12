import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;

  const Toolbar({
    Key? key,
    required this.title,
    this.bottom,
  }) : super(key: key);

  @override
  Size get preferredSize => Size(
      double.infinity, kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    return AppBar(
      title: Text(title),
      bottom: bottom,
      actions: [
        _buildChangeThemeBtn(context, linden),
      ],
    );
  }

  Widget _buildChangeThemeBtn(BuildContext context, Linden linden) {
    final isDark = linden.brightness == Brightness.dark;
    final icon = SvgPicture.asset(
      isDark ? linden.assets.icons.sun : linden.assets.icons.moon,
      color: linden.colors.iconInverse,
    );
    return IconButton(
      onPressed: () {
        final brightness = isDark ? Brightness.light : Brightness.dark;
        UnterDenLinden.of(context).changeBrightness(brightness);
      },
      icon: icon,
    );
  }
}
