import 'package:flutter/material.dart';
import 'animations.dart';
import 'assets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

@immutable
class Xayn {
  const Xayn._();

  static void setBaseTextTheme(TextTheme textTheme) {
    _baseTextTheme = textTheme;
    _styles = XStyles(_textTheme);
  }

  static void setScreenInfo({
    required Size screenSize,
    required Orientation deviceOrientation,
    required Function(String) logger,
    double notchPaddingLandscapeMode = 0.0,
  }) {
    if (screenSize != _screenSize ||
        deviceOrientation != _deviceOrientation ||
        notchPaddingLandscapeMode != _notchPaddingLandscapeMode) {
      _screenSize = screenSize;
      _deviceOrientation = deviceOrientation;
      _notchPaddingLandscapeMode = notchPaddingLandscapeMode;
      _sizes = XSizes(
        screenSize: _screenSize!,
        deviceOrientation: _deviceOrientation!,
        notchPaddingLandscapeMode: _notchPaddingLandscapeMode,
      );
    }
  }

  static void setBrightness(Brightness brightness) {
    _brightness = brightness;
    _colors = XColors(brightness);
    _assets = Assets(brightness);
  }

  static bool get isDarkMode => _brightness == Brightness.dark;

  static TextTheme? _baseTextTheme;
  static Size? _screenSize;
  static Orientation? _deviceOrientation;
  static late double _notchPaddingLandscapeMode;
  static Brightness? _brightness;
  static Brightness get brightness => _brightness ?? Brightness.light;
  static XStyles? _styles;
  static XSizes? _sizes;
  static XColors? _colors;
  static Assets? _assets;
  static Animations? _animations;
  static final XColors _defaultColors = XColors(Brightness.light);
  static final XSizes _defaultSizes = XSizes(
      screenSize: const Size(800, 600),
      deviceOrientation: Orientation.portrait);
  static final Assets _defaultAssets = Assets(Brightness.light);
  static final Animations _defaultAnimations = Animations();

  static TextTheme get _textTheme =>
      _baseTextTheme ?? Typography.material2018().white;
  static XStyles get styles => _styles ??= XStyles(_textTheme);

  // TODO need to change classes to non static access
  static XSizes get dimen => _sizes ?? _defaultSizes;

  static XColors get colors => _colors ?? _defaultColors;

  static Assets get assets => _assets ?? _defaultAssets;

  static Animations get animations => _animations ?? _defaultAnimations;

  /// This generates the default material or cupertino themes, but we don't want to use
  /// Theme.of to access those styles because they don't correspond with the R.styles
  /// design system
  static ThemeData createAppTheme({required Function onUpdateResources}) {
    var themeData = ThemeData(
      fontFamily: 'NotoSans',
      brightness: Xayn.colors.brightness,
      primaryColor: Xayn.colors.primary,
      // ignore: deprecated_member_use
      accentColor: Xayn.colors.accent,
      // ignore: deprecated_member_use
      buttonColor: Xayn.colors.primaryAction,
      appBarTheme: AppBarTheme(
        color: Xayn.colors.accent,
      ),
      dividerColor: Xayn.colors.divider,
      scaffoldBackgroundColor: Xayn.colors.pageBackground,
      inputDecorationTheme: Xayn.styles.hintTextDecoration,
      unselectedWidgetColor: Xayn.colors.iconDisabled,
    );

    // the base theme for all texts is then the generated material or cupertino
    // text theme.
    Xayn.setBaseTextTheme(themeData.textTheme);

    /// We use [MediaQueryData] to get the proper window's metrics that Flutter uses
    /// where size is calculated like:
    /// ```
    /// Size size = window.physicalSize / window.devicePixelRatio;
    /// ```

    onUpdateResources();

    // Override all default themes with [R.styles] themes at this point
    themeData = themeData.copyWith(
        textTheme: themeData.textTheme.copyWith(
      subtitle1: Xayn.styles.appHighlightText,
      bodyText1: Xayn.styles.appBodyText,
    ));
    return themeData;
  }
}
