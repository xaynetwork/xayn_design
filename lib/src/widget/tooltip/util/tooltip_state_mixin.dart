import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/xayn_design.dart';

mixin TooltipStateMixin<T extends StatefulWidget> on State<T> {
  final List<TooltipKey> _factoryKeys = <TooltipKey>[];
  late final TooltipController _tooltipController;

  @override
  void initState() {
    _tooltipController = Provider.of(context, listen: false);

    super.initState();
  }

  void registerTooltip({
    required TooltipKey key,
    required TooltipParams params,
  }) {
    _tooltipController.register(key: key, params: params);

    _factoryKeys.add(key);
  }

  void showTooltip(
    TooltipKey key, {
    TooltipStyle style = TooltipStyle.normal,
    List<dynamic>? parameters,
  }) =>
      _tooltipController.show(
        key,
        style: style,
        parameters: parameters,
      );
}
