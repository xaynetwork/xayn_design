import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/xayn_design.dart';

mixin TooltipStatelessMixin on StatelessWidget {
  void showTooltip(BuildContext context, TooltipData data) {
    final tooltipController =
        Provider.of<TooltipController>(context, listen: false);
    tooltipController.show(data);
  }

  void hideTooltip(BuildContext context) {
    final tooltipController =
        Provider.of<TooltipController>(context, listen: false);
    tooltipController.hide();
  }
}
