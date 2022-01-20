import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_container.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

import 'bottom_sheet_base.dart';

typedef _BottomSheetBuilder = BottomSheetBase Function(BuildContext context);

Future showAppBottomSheet(
  BuildContext context, {
  required _BottomSheetBuilder builder,
  bool showBarrierColor = true,
  bool hideNavBar = true,
}) {
  if (hideNavBar) {
    NavBarContainer.hideNavBar(context);
  }
  final linden = UnterDenLinden.getLinden(context);

  return showMaterialModalBottomSheet(
    context: context,
    enableDrag: false,
    elevation: linden.dimen.elevationHigh,
    shape: RoundedRectangleBorder(
      borderRadius: linden.styles.roundBorderBottomSheet,
    ),
    backgroundColor: linden.colors.bottomSheetBackgroundColor,
    barrierColor:
        showBarrierColor ? linden.colors.bottomSheetBarrierColor : null,
    builder: builder,
  );
}
