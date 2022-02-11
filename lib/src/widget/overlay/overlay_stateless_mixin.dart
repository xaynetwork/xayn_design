import 'package:flutter/material.dart';

import 'overlay_widget_builder.dart';

mixin OverlayStatelessMixin<T extends StatefulWidget> on State<T> {
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

  void toggleOverlay(BuildContext context, OverlayWidgetBuilder builder) =>
      isOverlayShown ? removeOverlay() : insertOverlay(context, builder);

  void insertOverlay(BuildContext context, OverlayWidgetBuilder builder) {
    _overlayEntry = OverlayEntry(builder: builder);
    Overlay.of(context)?.insert(_overlayEntry!);
  }
}
