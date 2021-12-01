import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xayn_design/xayn_design.dart';

/// A top-level wrapper [Widget].
/// It provides the Tooltip throughout the [Widget] tree and uses
/// [Tooltip.contextProvider] to dynamically assign the current [BuildContext],
/// which will be used for laying out the actual [Tooltip].
class ApplicationTooltipProvider extends SingleChildStatefulWidget {
  final MessageFactory messageFactory;

  const ApplicationTooltipProvider({
    required this.messageFactory,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  State<StatefulWidget> createState() => _ApplicationTooltipProviderState();
}

class _ApplicationTooltipProviderState
    extends SingleChildState<ApplicationTooltipProvider> {
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Tooltip.contextDeferred(
      messageFactory: widget.messageFactory,
      preferBelow: false,
      contextProvider: () {
        final controller =
            Provider.of<ApplicationTooltipController>(context, listen: false);

        return controller.targetContext ?? context;
      },
      child: child,
    );
  }
}

/// A top-level controller, can be obtained throughout the [Widget] tree.
/// Use [targetContext] to update the current [BuildContext] which will
/// be used for application [Tooltip]s as positional target.
class ApplicationTooltipController {
  BuildContext? _targetContext;

  BuildContext? get targetContext => _targetContext;

  set targetContext(BuildContext? context) {
    if (context != _targetContext) {
      _targetContext = context;
    }
  }
}
