import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:xayn_design/xayn_design.dart';

class AppSwitchWidget extends StatelessWidget {
  /// Current value of the switch (on/off)
  final bool value;

  /// If the [onToggle] is null - then the widget will be drawn as disabled and
  /// opacity will apply
  final ValueChanged<bool>? onToggle;

  const AppSwitchWidget({
    Key? key,
    required this.value,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final switchWidget = FlutterSwitch(
      value: value,
      onToggle: onToggle ?? (_) {},
      activeColor: linden.colors.accent,
      inactiveColor: linden.colors.divider,
      width: linden.dimen.unit7,
      height: linden.dimen.unit4,
      toggleSize: linden.dimen.unit3,
    );
    return Opacity(
      opacity: onToggle == null ? linden.dimen.disabledOpacity : 1,
      child: switchWidget,
    );
  }
}
