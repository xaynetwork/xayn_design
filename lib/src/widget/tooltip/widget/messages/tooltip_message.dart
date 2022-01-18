import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xayn_design/xayn_design.dart';

abstract class TooltipMessage extends StatefulWidget {
  final Duration timeToLive;

  const TooltipMessage({Key? key, required this.timeToLive}) : super(key: key);
}

mixin TooltipControllerProviderMixin<T extends TooltipMessage> on State<T> {
  late final TooltipController tooltipController;
  late final Timer timeToLiveTimer;

  @override
  void initState() {
    tooltipController = Provider.of(context, listen: false);

    timeToLiveTimer = Timer(widget.timeToLive, tooltipController.hide);

    super.initState();
  }

  @override
  void dispose() {
    timeToLiveTimer.cancel();

    super.dispose();
  }
}

class TooltipMessageContainer extends StatelessWidget
    with SingleChildStatelessWidgetMixin {
  final Linden linden;
  final TooltipStyle style;

  @override
  final Widget child;

  const TooltipMessageContainer({
    Key? key,
    required this.child,
    required this.linden,
    required this.style,
  }) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      style == TooltipStyle.normal
          ? _buildNormalStyleWithChild(child)
          : _buildArrowStyleWithChild(child);

  Widget _buildNormalStyleWithChild(Widget? child) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: linden.dimen.unit2,
      ),
      child: Material(
        type: MaterialType.button,
        elevation: linden.dimen.elevationLow,
        textStyle: linden.styles.tooltipText,
        borderRadius: BorderRadius.all(Radius.circular(linden.dimen.unit4)),
        color: linden.colors.tooltipBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: linden.dimen.unit2, vertical: linden.dimen.unit),
          child: child,
        ),
      ),
    );
  }

  Widget _buildArrowStyleWithChild(Widget? child) {
    return Material(
      type: MaterialType.button,
      elevation: linden.dimen.elevationLow,
      textStyle: linden.styles.tooltipArrowTextStyle,
      borderRadius: BorderRadius.all(Radius.circular(linden.dimen.unit1_5)),
      color: linden.colors.accent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: linden.dimen.unit2,
              right: linden.dimen.unit2,
              top: linden.dimen.unit,
              bottom: linden.dimen.unit1_5,
            ),
            child: child,
          ),
          Stack(
            children: [
              // Workaroud to eliminate hairline border when using fill painiting style.
              // Drawing two shapes one with fill style and the other with stroke style
              // on top of each other, fixes the small gap beween tooltip and bottom arrow.
              ...PaintingStyle.values.map(
                (value) => CustomPaint(
                  painter: _Triangle(linden, value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Triangle extends CustomPainter {
  final Linden linden;
  final PaintingStyle paintingStyle;

  const _Triangle(
    this.linden,
    this.paintingStyle,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = linden.colors.accent
      ..strokeWidth = 1
      ..style = paintingStyle;

    final path = Path();

    path.lineTo(-linden.dimen.unit, 0);
    path.conicTo(
      0,
      linden.dimen.unit1_5,
      linden.dimen.unit,
      0,
      linden.dimen.unit,
    );
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
