import 'package:flutter/material.dart';

const kDefaultSpacing = EdgeInsets.all(4.0);
const kDefaultShape = BoxShape.circle;
const kDefaultSize = Size.square(12.0);
const kDefaultBorderWidth = 2.0;

/// Used for adding decoration to the [DotsIndicator] widget
class DotsDecorator {
  /// Inactive dot color
  ///
  /// @Default `Colors.transparent`
  final Color color;

  /// Active dot color
  ///
  /// @Default `Colors.white`
  final Color activeColor;

  /// Dot border color
  ///
  /// @Default `Colors.white`
  final Color borderColor;

  /// Dot border width
  ///
  /// @Default `2.0`
  final double borderWidth;

  /// Space between dots
  ///
  /// @Default `EdgeInsets.all(4.0)`
  final EdgeInsets spacing;

  /// Dot shape
  ///
  /// @Default `BoxShape.circle`
  final BoxShape shape;

  /// Dot size
  ///
  /// @Default `Size.square(12.0)`
  final Size size;

  const DotsDecorator({
    Color? color,
    Color? activeColor,
    Color? borderColor,
    double? borderWidth,
    EdgeInsets? spacing,
    BoxShape? shape,
    Size? size,
  })  : color = color ?? Colors.transparent,
        activeColor = activeColor ?? Colors.white,
        borderColor = borderColor ?? Colors.white,
        borderWidth = borderWidth ?? kDefaultBorderWidth,
        spacing = spacing ?? kDefaultSpacing,
        shape = shape ?? kDefaultShape,
        size = size ?? kDefaultSize;
}
