import 'package:flutter/material.dart';
import 'package:xayn_design/src/linden/linden.dart';
import 'package:xayn_design/src/widget/tooltip/tooltip.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

import 'bottom_sheet_body_mixin.dart';

class BottomSheetBase extends StatefulWidget {
  const BottomSheetBase({
    Key? key,
    required this.body,
    this.padding,
    this.onSystemPop,
    this.withApplicationTooltipProvider = true,
  }) : super(key: key);

  final Widget body;
  final EdgeInsets? padding;
  final VoidCallback? onSystemPop;
  final bool withApplicationTooltipProvider;

  @override
  _BottomSheetBaseState createState() => _BottomSheetBaseState();
}

class _BottomSheetBaseState extends State<BottomSheetBase>
    with BottomSheetBodyMixin {
  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final paddedBody = Padding(
      padding: widget.padding ?? _buildWithDefaultPadding(linden),
      child: widget.body,
    );

    final constrainedChild = LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: constraints.maxHeight * 0.9,
          maxWidth: linden.dimen.bottomSheetMaxWidth,
        ),
        child: paddedBody,
      ),
    );

    Widget avoidKeyboardChild = Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: constrainedChild,
      ),
    );

    if (widget.withApplicationTooltipProvider) {
      avoidKeyboardChild = ApplicationTooltipProvider(
        child: avoidKeyboardChild,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.onSystemPop != null) {
          widget.onSystemPop!();
        }
        return true;
      },
      child: avoidKeyboardChild,
    );
  }

  EdgeInsets _buildWithDefaultPadding(Linden linden) {
    final deviceBottomPadding = linden.dimen.deviceScreenPadding.bottom;
    return EdgeInsets.only(
      top: linden.dimen.unit2,
      left: linden.dimen.unit3,
      right: linden.dimen.unit3,
      bottom: deviceBottomPadding == 0 ? linden.dimen.unit3 : 0.0,
    );
  }
}
