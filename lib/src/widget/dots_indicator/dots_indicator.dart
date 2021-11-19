import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

import 'dots_decorator.dart';

/// A widget used to display customizable dots in a row.
///
/// Usually used in combination with a [PageView] in order to
/// highlight the index of the current page
///
/// If [decorator] is null then the [DotsDecorator] object is created
/// by following the Xayn design system
class DotsIndicator extends StatelessWidget {
  final int dotsNumber;
  final int activePosition;
  final DotsDecorator? decorator;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  const DotsIndicator({
    Key? key,
    required this.dotsNumber,
    required this.activePosition,
    this.decorator,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  })  : assert(dotsNumber > 0),
        assert(activePosition >= 0),
        assert(activePosition < dotsNumber),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotsDecorator = decorator ?? _buildXaynDotsDecorator(context);

    final dotsList = List<Widget>.generate(
      dotsNumber,
      (index) => _buildDot(
        index,
        dotsDecorator,
      ),
    );

    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      children: dotsList,
    );
  }

  DotsDecorator _buildXaynDotsDecorator(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    return DotsDecorator(
      color: linden.colors.dotsIndicatorColor,
      activeColor: linden.colors.dotsIndicatorActiveColor,
      borderColor: linden.colors.dotsIndicatorBorderColor,
      spacing: EdgeInsets.all(linden.dimen.unit0_5),
      size: Size.square(
        linden.dimen.unit1_5,
      ),
      borderWidth: linden.dimen.unit0_25,
      shape: BoxShape.circle,
    );
  }

  Widget _buildDot(int index, DotsDecorator decorator) {
    final color =
        index == activePosition ? decorator.activeColor : decorator.color;

    return Container(
      height: decorator.size.height,
      width: decorator.size.width,
      margin: decorator.spacing,
      decoration: BoxDecoration(
        color: color,
        shape: decorator.shape,
        border: Border.all(
          color: decorator.borderColor,
          width: decorator.borderWidth,
        ),
      ),
    );
  }
}
