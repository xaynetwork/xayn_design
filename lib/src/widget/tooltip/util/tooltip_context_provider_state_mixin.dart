import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/xayn_design.dart';

mixin TooltipContextProviderStateMixin<T extends StatefulWidget> on State<T> {
  late final ApplicationTooltipController _applicationTooltipController;
  late final BuildContext? oldContext;

  @override
  void initState() {
    _applicationTooltipController = Provider.of(context, listen: false);

    oldContext = _applicationTooltipController.targetContext;

    super.initState();
  }

  @override
  void dispose() {
    _applicationTooltipController.targetContext = oldContext;

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // tell the application tooltip that this Widget is the target Widget
    // for rendering notifications above/below.
    _applicationTooltipController.targetContext =
        resolveTooltipTargetContext(context);

    super.didChangeDependencies();
  }

  BuildContext resolveTooltipTargetContext(BuildContext context) => context;
}

class TooltipContextProvider extends StatefulWidget {
  final Widget child;

  const TooltipContextProvider({Key? key, required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TooltipContextProviderState();
}

class _TooltipContextProviderState extends State<TooltipContextProvider>
    with TooltipContextProviderStateMixin {
  @override
  Widget build(BuildContext context) => widget.child;
}
