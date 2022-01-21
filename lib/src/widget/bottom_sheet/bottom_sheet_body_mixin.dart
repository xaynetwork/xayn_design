import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

mixin BottomSheetBodyMixin {
  ScrollController? getScrollController(BuildContext context) =>
      ModalScrollController.of(context);

  void closeBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
