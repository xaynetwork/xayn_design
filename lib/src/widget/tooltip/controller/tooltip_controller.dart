import 'package:flutter/widgets.dart';
import 'package:xayn_design/xayn_design.dart';

class TooltipController extends ChangeNotifier {
  TooltipData? _activeData;

  /// The key for the message which is actively being displayed.
  /// The key should is tied to a handler which returns an implementation of [TooltipMessage].
  TooltipData? get activeTooltipData => _activeData;

  TooltipController();

  /// Displays a tooltip for the requested [key].
  /// Use [style] to change visual appearance of a tooltip.
  /// Use [parameters] to provide optional information, which can be used
  /// when creating a corresponding [TooltipMessage].
  void show(TooltipData data) {
    if (data != _activeData) {
      _activeData = data;

      notifyListeners();
    }
  }

  /// Hides the active tooltip.
  void hide() {
    if (_activeData != null) {
      _activeData = null;

      notifyListeners();
    }
  }
}
