import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/xayn_design.dart';

mixin TooltipStateMixin<T extends StatefulWidget> on State<T> {
  late final TooltipController _tooltipController;

  @override
  void initState() {
    _tooltipController = Provider.of(context, listen: false);

    super.initState();
  }

  void showTooltip(
    TooltipData data,
  ) =>
      _tooltipController.show(data);

  void hideTooltip() => _tooltipController.hide();
}
