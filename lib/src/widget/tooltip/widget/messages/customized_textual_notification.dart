import 'package:flutter/material.dart';
import 'package:xayn_design/src/utils/text_utils.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration _kTimeToLive = Duration(seconds: 3);

typedef _ParameterCallback = void Function(List<dynamic>? parameters);

enum IconPosition { start, end }

class CustomizedTextualNotification extends TooltipMessage {
  final double? width, height;
  final String? highlightText;
  final String? icon;
  final Color? iconColor;
  final TextStyle? labelTextStyle;
  final TextStyle? highlightTextStyle;
  final IconPosition iconPosition;
  final _ParameterCallback? onTap;

  const CustomizedTextualNotification({
    Key? key,
    this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.iconPosition = IconPosition.end,
    this.labelTextStyle,
    this.highlightText,
    this.highlightTextStyle,
    this.onTap,
  }) : super(key: key, timeToLive: _kTimeToLive);

  @override
  TooltipMessageState createState() => _TextualNotificationState();
}

class _TextualNotificationState
    extends TooltipMessageState<CustomizedTextualNotification> {
  String? get highlightText => widget.highlightText;

  TextStyle? get labelTextStyle =>
      widget.labelTextStyle ?? linden.styles.tooltipText;

  TextStyle? get highlightTextStyle =>
      widget.highlightTextStyle ?? linden.styles.tooltipHighlightTextStyle;

  String? get icon => widget.icon;

  @override
  Widget build(BuildContext context) {
    final iconWithText = [
      if (tooltipController.activeKey != null)
        Flexible(
          child: _getText(
            tooltipController.keyToLabel(tooltipController.activeKey!),
          ),
        ),
      if (icon != null) ...[
        SizedBox(
          width: linden.dimen.unit,
        ),
        SvgPicture.asset(
          icon!,
          color: widget.iconColor ?? linden.colors.icon,
        ),
      ],
    ];

    final orderedIconWithText = widget.iconPosition == IconPosition.start
        ? iconWithText.reversed
        : iconWithText;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: orderedIconWithText.toList(),
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

  Widget _getText(String text) {
    if (highlightText == null) {
      return buildText(style: labelTextStyle);
    }

    return getHighlightedText(
      text: text,
      highlight: highlightText!,
      highlightTextStyle: highlightTextStyle,
      labelTextStyle: labelTextStyle,
    );
  }
}
