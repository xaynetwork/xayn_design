import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration kTimeToLive = Duration(seconds: 3);

class TextualNotification extends TooltipMessage {
  final double? width, height;
  final String? icon;
  final VoidCallback? onTap;

  const TextualNotification({
    Key? key,
    required String label,
    TooltipStyle style = TooltipStyle.normal,
    this.width,
    this.height,
    this.icon,
    this.onTap,
  }) : super(key: key, timeToLive: kTimeToLive, label: label, style: style);

  @override
  TooltipMessageState createState() => _TextualNotificationState();
}

class _TextualNotificationState
    extends TooltipMessageState<TextualNotification> {
  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          buildIcon(
            icon,
            color: linden.colors.primary,
          ),
          SizedBox(
            width: linden.dimen.unit,
          )
        ],
        Flexible(child: buildText()),
      ],
    );

    return GestureDetector(
      onTap: () {
        final tap = widget.onTap;
        if (tap != null) {
          tap();
        }

        tooltipController.hide();
      },
      child: buildTooltipContainer(content),
    );
  }
}
