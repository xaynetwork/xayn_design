import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xayn_design/xayn_design.dart';

typedef OnLindenUpdated = Function(Linden linden);

/// Should be the highest level widget in the three.
/// Maintain updating application widget tree when [Linden] changes
class UnterDenLinden extends StatefulWidget {
  /// Ideally this should be the app widget
  final Widget child;

  /// Initial value of the [Linden]
  final Linden initialLinden;

  /// Add this callback if you would like to be notified when [Linden] changed
  /// inside [_UnterDenLindenState]
  final OnLindenUpdated? onLindenUpdated;

  const UnterDenLinden({
    Key? key,
    required this.child,
    required this.initialLinden,
    this.onLindenUpdated,
  }) : super(key: key);

  @override
  _UnterDenLindenState createState() => _UnterDenLindenState();

  /// Allows to achieve all public methods in[_UnterDenLindenState]
  ///
  /// The only one public method is [changeBrightness],
  /// which should be called when user would like manually change [Brightness]
  static _UnterDenLindenState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_LindenUpdater>()!.data;

  /// Return current instance of the [Linden].
  /// Can be used everywhere with context (cos [UnterDenLinden] wrap everything)
  /// The main purpose: use this method inside the `xayn_design` package
  /// for the internal widgets.
  static Linden getLinden(BuildContext context) => of(context)._linden;
}

class _UnterDenLindenState extends State<UnterDenLinden>
    with WidgetsBindingObserver {
  late Linden _linden;

  /// Change [Brightness] of the current app.
  /// If [Brightness] was changed - triggers rebuild of the whole app
  void changeBrightness(Brightness brightness) {
    if (brightness == _linden.brightness) return;

    final style = SystemUiOverlayStyle(statusBarBrightness: brightness);
    SystemChrome.setSystemUIOverlayStyle(style);

    final newLinden = _linden.updateBrightness(brightness);
    _updateLinden(newLinden);
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _linden = widget.initialLinden;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _updateScreenData();
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    _updateScreenData();

    return _LindenUpdater(
      data: this,
      child: widget.child,
    );
  }

  /// Should be triggered when [Linden.screenSize] is null
  /// or when screen params changed (rotation, resize, etc)
  void _updateScreenData() {
    final mediaQueryData =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

    ///When in landscape mode, regardless the orientation (left or right)
    ///if there is a notch both padding.right and padding.left return
    ///the notch padding value
    ///If there is no notch the padding value is 0.0
    final notchPaddingLandscapeMode = mediaQueryData.padding.right;

    final newLinden = _linden.updateScreenInfo(
      screenSize: mediaQueryData.size,
      deviceOrientation: mediaQueryData.orientation,
      notchPaddingLandscapeMode: notchPaddingLandscapeMode,
    );
    _updateLinden(newLinden);
  }

  void _updateLinden(Linden linden) {
    if (linden == _linden) return;
    widget.onLindenUpdated?.call(linden);
    setState(() {
      _linden = linden;
    });
  }
}

class _LindenUpdater extends InheritedWidget {
  final _UnterDenLindenState data;

  const _LindenUpdater({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_LindenUpdater oldWidget) {
    return true;
  }
}
