import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class AppCardWidget extends StatelessWidget {
  /// Enable border line around card
  final bool isHighlighted;

  final BorderRadiusGeometry? borderRadius;

  /// If not provided, then by default will apply [XSizes.elevationHigh]
  final double? elevation;

  /// If not provided, then by default will apply [XSizes.unit0_25]
  final double? highlightedLineWidth;

  /// If not provided, then by default will apply:
  /// [EdgeInsets.all(XSizes.unit2)]
  final EdgeInsets? contentPadding;

  /// If not provided, then by default will apply:
  /// [XColors.cardBackground]
  final Color? cardBackground;

  final Widget child;

  const AppCardWidget({
    Key? key,
    required this.child,
    this.isHighlighted = false,
    this.elevation,
    this.contentPadding,
    this.borderRadius,
    this.highlightedLineWidth,
    this.cardBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final borderSide = BorderSide(
      style: BorderStyle.solid,
      width: highlightedLineWidth ?? linden.dimen.unit0_25,
      color: isHighlighted
          ? linden.colors.cardBorderHighlight
          : linden.colors.transparent,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? linden.styles.roundBorder,
      side: borderSide,
    );

    final withPadding = Padding(
      padding: contentPadding ?? EdgeInsets.all(linden.dimen.unit2),
      child: child,
    );

    return Semantics(
      container: true,
      child: Material(
        type: MaterialType.card,
        elevation: elevation ?? linden.dimen.elevationHigh,
        shadowColor: linden.colors.shadowTransparent,
        color: cardBackground ?? linden.colors.cardBackground,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        child: Semantics(
          explicitChildNodes: false,
          child: withPadding,
        ),
      ),
    );
  }
}
