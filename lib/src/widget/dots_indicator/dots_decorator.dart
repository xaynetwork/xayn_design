import 'package:flutter/material.dart';

const kDefaultSpacing = EdgeInsets.all(4.0);
const kDefaultShape = BoxShape.circle;
const kDefaultSize = Size.square(12.0);
const kDefaultBorderWidth = 2.0;

class DotsDecorator {
  final Color color;
  final Color activeColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets spacing;
  final BoxShape shape;
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
