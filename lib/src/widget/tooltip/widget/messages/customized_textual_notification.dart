import 'package:flutter/material.dart';
import 'package:xayn_design/src/utils/text_utils.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration _kTimeToLive = Duration(seconds: 3);

enum IconPosition { start, end }

class CustomizedTextualNotification extends TooltipMessage {
  final double? width, height;
  final String? highlightText;
  final String? icon;
  final Color? iconColor;
  final TextStyle? labelTextStyle;
  final TextStyle? highlightTextStyle;
  final IconPosition iconPosition;
  final VoidCallback? onTap;

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
    required String label,
    TooltipStyle style = TooltipStyle.normal,
  }) : super(
          key: key,
          timeToLive: _kTimeToLive,
          style: style,
          label: label,
        );

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
    final tooltipData = tooltipController.activeTooltipData;
    final iconWithText = [
      if (tooltipData != null)
        Flexible(
          child: _getText(
            widget.label,
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
        var tap = widget.onTap;
        if (tap != null) {
          tap();
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
