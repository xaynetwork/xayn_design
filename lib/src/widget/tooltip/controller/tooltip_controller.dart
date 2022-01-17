import 'package:flutter/widgets.dart';
import 'package:xayn_design/xayn_design.dart';

class TooltipController extends ChangeNotifier {
  MessageFactory _customFactory = const {};
  TooltipKey? _activeKey;
  List<dynamic>? _activeParameters;
  var _style = TooltipStyle.normal;

  /// The key for the message which is actively being displayed.
  /// The key should is tied to a handler which returns an implementation of [TooltipMessage].
  TooltipKey? get activeKey => _activeKey;

  TooltipStyle get style => _style;

  /// A List of optional parameters which can be passed to the [TooltipMessage]
  /// which is created from the corresponding [activeKey].
  List<dynamic>? get activeParameters => _activeParameters;

  MessageFactory get customFactory => _customFactory;

  TooltipController();

  String keyToLabel(TooltipKey key) => _customFactory[key]!.label;

  /// Registers a new [key] with a corresponding [builder].
  void register({required TooltipKey key, required TooltipParams params}) {
    _customFactory = Map<TooltipKey, TooltipParams>.from(_customFactory);

    _customFactory[key] = params;
  }

  /// Displays a tooltip for the requested [key].
  /// Use [parameters] to provide optional information, which can be used
  /// when creating a corresponding [TooltipMessage].
  void show(
    TooltipKey key, {
    TooltipStyle style = TooltipStyle.normal,
    List<dynamic>? parameters,
  }) {
    if (key != _activeKey) {
      _activeKey = key;
      _style = style;
      _activeParameters = parameters;

      notifyListeners();
    }
  }

  /// Hides the active tooltip.
  void hide() {
    if (_activeKey != null) {
      _activeKey = null;
      _activeParameters = null;
      _style = TooltipStyle.normal;

      notifyListeners();
    }
  }
}
