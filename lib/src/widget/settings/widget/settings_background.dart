import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsBackground extends StatelessWidget {
  final Widget child;

  const SettingsBackground({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    return ClipRRect(
      borderRadius: linden.styles.roundBorder,
      child: Container(
        decoration: BoxDecoration(
          color: linden.colors.settingsCardBackground,
          borderRadius: linden.styles.roundBorder,
        ),
        child: child,
      ),
    );
  }
}
