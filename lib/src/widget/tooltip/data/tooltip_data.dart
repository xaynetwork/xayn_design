import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:xayn_design/src/widget/tooltip/tooltip.dart';

typedef TooltipBuilder<T> = TooltipMessage Function(
    BuildContext context, TooltipData data);

class TooltipData extends Equatable {
  final String key;
  final TooltipBuilder builder;
  // TODO try to remove the style, but right now it is necessary for the [Tooltip] class
  final TooltipStyle style;

  const TooltipData({
    required this.key,
    required this.builder,
    this.style = TooltipStyle.normal,
  });

  Widget build(BuildContext context) => builder(context, this);

  /// The builder is not part of the props because functions can only be compared by object hashCode
  @override
  List<Object?> get props => [key, style];

  static textual({
    required String key,
    required String label,
    VoidCallback? onTap,
    double? width,
    double? height,
    String? icon,
    Key? widgetKey,
  }) =>
      TooltipData(
          key: key,
          builder: (c, data) => TextualNotification(
                label: label,
                onTap: onTap,
                width: width,
                height: height,
                icon: icon,
                style: data.style,
                key: widgetKey,
              ));

  static customized({
    required String key,
    required String label,
    TextStyle? labelTextStyle,
    VoidCallback? onTap,
    double? width,
    double? height,
    String? icon,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.end,
    String? highlightText,
    TextStyle? highlightTextStyle,
    Key? widgetKey,
  }) =>
      TooltipData(
          key: key,
          builder: (c, data) => CustomizedTextualNotification(
                label: label,
                labelTextStyle: labelTextStyle,
                onTap: onTap,
                width: width,
                height: height,
                icon: icon,
                iconPosition: iconPosition,
                iconColor: iconColor,
                style: data.style,
                key: widgetKey,
                highlightText: highlightText,
                highlightTextStyle: highlightTextStyle,
              ));
}
