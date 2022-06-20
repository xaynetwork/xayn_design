import 'package:flutter/material.dart';
import 'package:xayn_design/src/linden/linden.dart';

class AppUnderlineTabIndicator extends UnderlineTabIndicator {
  final Linden linden;

  const AppUnderlineTabIndicator({
    required this.linden,
    BorderSide borderSide = const BorderSide(width: .0, color: Colors.white),
    EdgeInsets insets = EdgeInsets.zero,
  }) : super(
          borderSide: borderSide,
          insets: insets,
        );

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _AppUnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }
}

class _AppUnderlinePainter extends BoxPainter {
  _AppUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final AppUnderlineTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final rect = offset & configuration.size!;
    final textDirection = configuration.textDirection!;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.square;
    final s1 = decoration.linden.dimen.unit0_25 / 2.0,
        s2 = decoration.linden.dimen.unit0_25;
    final path = Path()
      ..moveTo(indicator.bottomLeft.dx, indicator.bottomLeft.dy)
      ..lineTo(indicator.bottomLeft.dx, indicator.bottomLeft.dy - s1)
      ..quadraticBezierTo(indicator.bottomLeft.dx, indicator.bottomLeft.dy - s2,
          indicator.bottomLeft.dx + s1, indicator.bottomLeft.dy - s2)
      ..lineTo(indicator.bottomRight.dx - s1, indicator.bottomRight.dy - s2)
      ..quadraticBezierTo(
          indicator.bottomRight.dx,
          indicator.bottomRight.dy - s2,
          indicator.bottomRight.dx,
          indicator.bottomRight.dy - s1)
      ..lineTo(indicator.bottomRight.dx, indicator.bottomRight.dy)
      ..close();

    paint.color = decoration.linden.colors.accent;

    canvas.drawPath(path, paint);
  }
}
