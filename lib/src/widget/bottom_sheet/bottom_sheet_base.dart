import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

import 'bottom_sheet_body_mixin.dart';

class BottomSheetBase extends StatefulWidget {
  const BottomSheetBase({
    Key? key,
    required this.body,
    this.padding,
    this.onSystemPop,
  }) : super(key: key);

  final Widget body;
  final EdgeInsets? padding;
  final VoidCallback? onSystemPop;

  @override
  _BottomSheetBaseState createState() => _BottomSheetBaseState();
}

class _BottomSheetBaseState extends State<BottomSheetBase>
    with BottomSheetBodyMixin {
  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final paddedBody = Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: linden.dimen.unit3,
          ),
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

    final avoidKeyboardChild = Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: constrainedChild,
    );

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
}
