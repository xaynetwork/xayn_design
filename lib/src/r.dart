import 'package:flutter/material.dart';
import 'utils/safe_platform.dart';
import 'animations.dart';
import 'assets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

class R {
  const R._();

  static void setBaseTextTheme(TextTheme textTheme) {
    _baseTextTheme = textTheme;
    _styles = XStyles(_textTheme);
  }

  static void setScreenInfo(
      {required Size screenSize,
      required Orientation deviceOrientation,
      double notchPaddingLandscapeMode = 0.0}) {
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

      // logger.i(
      //     'screenSize $_screenSize, orientation: $deviceOrientation, notchPaddingLandscapeMode: $_notchPaddingLandscapeMode');
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
      screenSize: Size(800, 600), deviceOrientation: Orientation.portrait);
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

  static bool get isWeb => SafePlatform.isWeb;

  static bool get isAndroid => SafePlatform.isAndroid;

  static bool get isIOS => SafePlatform.isIOS;

  static bool get isFuchsia => SafePlatform.isFuchsia;

  static bool get isLinux => SafePlatform.isLinux;

  static bool get isMacOS => SafePlatform.isMacOS;

  static bool get isWindows => SafePlatform.isWindows;
}
