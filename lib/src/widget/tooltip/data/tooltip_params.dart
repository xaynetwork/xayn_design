import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

typedef MessageBuilder = TooltipMessage Function(BuildContext context);

class TooltipParams {
  final String label;
  final MessageBuilder builder;

  const TooltipParams({
    required this.label,
    required this.builder,
  });
}
