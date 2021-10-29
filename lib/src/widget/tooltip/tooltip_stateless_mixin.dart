import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/xayn_design.dart';

mixin TooltipStatelessMixin on StatelessWidget {
  void registerTooltip({
    required BuildContext context,
    required TooltipKey key,
    required TooltipParams params,
  }) {
    final _tooltipController =
        Provider.of<TooltipController>(context, listen: false);
    _tooltipController.register(key: key, params: params);
  }

  void showTooltip(BuildContext context, TooltipKey key,
      [List<dynamic>? parameters]) {
    final _tooltipController =
        Provider.of<TooltipController>(context, listen: false);
    _tooltipController.show(key, parameters);
  }
}
