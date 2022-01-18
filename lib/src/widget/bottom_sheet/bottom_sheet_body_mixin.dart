import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_container.dart';

mixin BottomSheetBodyMixin {
  ScrollController? getScrollController(BuildContext context) =>
      ModalScrollController.of(context);

  void closeBottomSheet(
    BuildContext context, {
    bool showNavBar = true,
  }) {
    Navigator.pop(context);
    onCloseBottomSheet(context, showNavBar: showNavBar);
  }

  void onCloseBottomSheet(
    BuildContext context, {
    bool showNavBar = true,
  }) {
    if (showNavBar) {
      NavBarContainer.showNavBar(context);
    }
  }
}
