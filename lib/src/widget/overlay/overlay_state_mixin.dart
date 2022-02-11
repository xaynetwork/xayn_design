import 'package:flutter/material.dart';

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

  void toggleOverlay(Positioned positionedChild) =>
      isOverlayShown ? removeOverlay() : insertOverlay(positionedChild);

  void insertOverlay(Positioned child) {
    _overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context)?.insert(_overlayEntry!);
  }
}
