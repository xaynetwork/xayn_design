import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration kTimeToLive = Duration(seconds: 3);

typedef ParameterCallback = void Function(List<dynamic>? parameters);

class TextualNotification extends TooltipMessage {
  final double? width, height;
  final String? icon;
  final ParameterCallback? onTap;

  const TextualNotification({
    Key? key,
    this.width,
    this.height,
    this.icon,
    this.onTap,
  }) : super(key: key, timeToLive: kTimeToLive);

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
        if (tooltipController.activeKey != null) Flexible(child: buildText()),
      ],
    );

    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(tooltipController.activeParameters);
        }

        tooltipController.hide();
      },
      child: buildTooltipContainer(content),
    );
  }
}
