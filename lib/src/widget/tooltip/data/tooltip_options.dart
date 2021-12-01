import 'package:flutter/widgets.dart';

class TooltipOptions {
  final String label;
  final Icon? icon;
  final Alignment alignment;

  const TooltipOptions({
    this.label = '',
    this.icon,
    this.alignment = Alignment.bottomRight,
  });
}
