import 'package:flutter/material.dart';

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

  void toggleOverlay(BuildContext context, Positioned positionedChild) =>
      isOverlayShown
          ? removeOverlay()
          : insertOverlay(context, positionedChild);

  void insertOverlay(BuildContext context, Positioned child) {
    _overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context)?.insert(_overlayEntry!);
  }
}
