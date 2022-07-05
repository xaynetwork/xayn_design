import 'package:flutter/material.dart';

import 'overlay_widget_builder.dart';

mixin OverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  bool get isOverlayShown => _overlayEntry != null;

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void toggleOverlay(
          {required OverlayWidgetBuilder builder,
          bool useRootOverlay = false}) =>
      isOverlayShown ? removeOverlay() : insertOverlay(builder, useRootOverlay);

  void insertOverlay(OverlayWidgetBuilder builder, bool useRootOverlay) {
    _overlayEntry = OverlayEntry(builder: builder);
    Overlay.of(context, rootOverlay: useRootOverlay)?.insert(_overlayEntry!);
  }
}
