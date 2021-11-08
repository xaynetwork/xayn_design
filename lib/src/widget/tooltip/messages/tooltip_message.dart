import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  @override
  final Widget child;

  const TooltipMessageContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Linden.dimen.unit2,
      ),
      child: Material(
        type: MaterialType.button,
        elevation: Linden.dimen.elevationLow,
        textStyle: Linden.styles.tooltipText,
        borderRadius: BorderRadius.all(Radius.circular(Linden.dimen.unit4)),
        color: Linden.colors.tooltipBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Linden.dimen.unit2, vertical: Linden.dimen.unit),
          child: child,
        ),
      ),
    );
  }
}
