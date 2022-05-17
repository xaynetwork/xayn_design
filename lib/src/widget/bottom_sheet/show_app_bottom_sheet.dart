import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

import 'bottom_sheet_base.dart';

typedef BottomSheetBuilder = BottomSheetBase Function(BuildContext context);

Future showAppBottomSheet(
  BuildContext context, {
  required BottomSheetBuilder builder,
  bool showBarrierColor = true,
  bool isDismissible = true,

  ///Showing multiple sheets on top of each other
  bool allowStacking = true,
}) {
  final linden = UnterDenLinden.getLinden(context);

  if (!allowStacking) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.isBottomSheetDisplayed()) return Future.value();
  }

  return showMaterialModalBottomSheet(
    context: context,
    enableDrag: false,
    useRootNavigator: true,
    isDismissible: isDismissible,
    elevation: linden.dimen.elevationHigh,
    shape: RoundedRectangleBorder(
      borderRadius: linden.styles.roundBorderBottomSheet,
    ),
    backgroundColor: linden.colors.bottomSheetBackgroundColor,
    barrierColor: showBarrierColor
        ? linden.colors.bottomSheetBarrierColor
        : linden.colors.transparent,
    builder: builder,
  );
}

extension on NavigatorState {
  bool isBottomSheetDisplayed() {
    late bool isDisplayed;
    popUntil((route) {
      isDisplayed = route.isCurrent && route is ModalBottomSheetRoute;
      return true;
    });
    return isDisplayed;
  }
}
