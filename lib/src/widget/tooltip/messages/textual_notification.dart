import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration kTimeToLive = Duration(seconds: 3);

typedef ParameterCallback = void Function(List<dynamic>? parameters);

class TextualNotification extends TooltipMessage {
  final Linden linden;
  final double? width, height;
  final String? icon;
  final ParameterCallback? onTap;

  const TextualNotification({
    required this.linden,
    Key? key,
    this.width,
    this.height,
    this.icon,
    this.onTap,
  }) : super(key: key, timeToLive: kTimeToLive);

  @override
  State<StatefulWidget> createState() => _TextualNotificationState();
}

class _TextualNotificationState extends State<TextualNotification>
    with TooltipControllerProviderMixin {
  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          SvgPicture.asset(
            icon,
            color: widget.linden.colors.primary,
          ),
          SizedBox(
            width: widget.linden.dimen.unit,
          )
        ],
        if (tooltipController.activeKey != null)
          Flexible(
            child: Text(
              tooltipController.keyToLabel(tooltipController.activeKey!),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );

    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(tooltipController.activeParameters);
        }

        tooltipController.hide();
      },
      child: TooltipMessageContainer(
        linden: widget.linden,
        child: content,
      ),
    );
  }
}
