import 'package:flutter/material.dart';
import 'package:xayn_design/src/linden/xsizes.dart';
import 'package:xayn_design/xayn_design.dart';

class AppCardWidget extends StatelessWidget {
  /// Enable border line around card
  final bool isHighlighted;

  final BorderRadiusGeometry? borderRadius;

  /// If not provided, then by default will apply [XSizes.elevationHigh]
  final double? elevation;

  /// If not provided, then by default will apply:
  /// [EdgeInsets.all(XSizes.unit2)]
  final EdgeInsets? contentPadding;

  final Widget child;

  const AppCardWidget({
    Key? key,
    required this.child,
    this.isHighlighted = false,
    this.elevation,
    this.contentPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final borderSide = BorderSide(
      style: BorderStyle.solid,
      width: 2,
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
        color: linden.colors.cardBackground,
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
