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
    this.color = Colors.transparent,
    this.activeColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = kDefaultBorderWidth,
    this.spacing = kDefaultSpacing,
    this.shape = kDefaultShape,
    this.size = kDefaultSize,
  });
}
