import 'package:flutter/material.dart';
import 'xanimations.dart';
import 'xassets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

@immutable
class Linden {
  Linden({
    this.screenSize,
    this.deviceOrientation = Orientation.portrait,
    this.notchPaddingLandscapeMode = 0,
    this.brightness = Brightness.light,
    this.dimen = const XSizes(),
    this.animations = const XAnimations(),
    XStyles? styles,
    ThemeData? themeData,
    XColors? colors,
    XAssets? assets,
  })  : assets = assets ?? XAssets(brightness: brightness),
        colors = colors ?? XColors(brightness: brightness),
        styles = styles ??= XStyles(
          _defaultTheme(brightness).textTheme,
          brightness: brightness,
        ),
        themeData = themeData ?? _defaultTheme(brightness, styles: styles);

  final Size? screenSize;
  final Orientation deviceOrientation;

  /// When in landscape mode, regardless the orientation (left or right)
  /// if there is a notch both padding.right and padding.left return
  /// the notch padding value
  /// If there is no notch the padding value is 0.0
  final double notchPaddingLandscapeMode;

  final Brightness brightness;
  final XStyles styles;
  final ThemeData themeData;
  final XSizes dimen;
  final XColors colors;
  final XAssets assets;
  final XAnimations animations;

  Linden copyWith({
    Size? screenSize,
    Orientation? deviceOrientation,
    double? notchPaddingLandscapeMode,
    Brightness? brightness,
    XStyles? styles,
    ThemeData? themeData,
    XSizes? dimen,
    XColors? colors,
    XAssets? assets,
    XAnimations? animations,
  }) =>
      Linden(
        screenSize: screenSize ?? this.screenSize,
        deviceOrientation: deviceOrientation ?? this.deviceOrientation,
        notchPaddingLandscapeMode:
            notchPaddingLandscapeMode ?? this.notchPaddingLandscapeMode,
        brightness: brightness ?? this.brightness,
        styles: styles ?? this.styles,
        themeData: themeData ?? this.themeData,
        dimen: dimen ?? this.dimen,
        colors: colors ?? this.colors,
        assets: assets ?? this.assets,
        animations: animations ?? this.animations,
      );

  Linden updateScreenInfo({
    required Size screenSize,
    required Orientation deviceOrientation,
    double notchPaddingLandscapeMode = 0.0,
  }) {
    if (screenSize != this.screenSize ||
        deviceOrientation != this.deviceOrientation ||
        notchPaddingLandscapeMode != this.notchPaddingLandscapeMode) {
      return copyWith(
        screenSize: screenSize,
        deviceOrientation: deviceOrientation,
        notchPaddingLandscapeMode: notchPaddingLandscapeMode,
        dimen: XSizes(
          screenSize: screenSize,
          deviceOrientation: deviceOrientation,
          notchPaddingLandscapeMode: notchPaddingLandscapeMode,
        ),
      );
    }
    return this;
  }

  Linden updateBrightness(Brightness brightness) => copyWith(
        brightness: brightness,
        colors: XColors(brightness: brightness),
        assets: XAssets(brightness: brightness),
        styles: XStyles(
          _defaultTheme(brightness).textTheme,
          brightness: brightness,
        ),
        themeData: _defaultTheme(brightness, styles: styles),
      );
}

ThemeData _defaultTheme(Brightness brightness, {XStyles? styles}) {
  final colors = XColors(brightness: brightness);
  final colorScheme = brightness == Brightness.light
      ? const ColorScheme.light()
      : const ColorScheme.dark().copyWith(
          onSurface: colors.background,
          onBackground: colors.background,
        );
  return ThemeData(
    fontFamily: 'NotoSans',
    brightness: brightness,
    primaryColor: colors.primary,
    colorScheme: colorScheme.copyWith(secondary: colors.accent),
    appBarTheme: AppBarTheme(
      color: colors.accent,
    ),
    dialogBackgroundColor: colors.pageBackground,
    dividerColor: colors.divider,
    scaffoldBackgroundColor: colors.pageBackground,
    unselectedWidgetColor: colors.iconDisabled,
    inputDecorationTheme: styles?.hintTextDecoration,
    textTheme: styles == null
        ? null
        : _defaultTheme(brightness).textTheme.copyWith(
              subtitle1: styles.appHighlightText,
              bodyText1: styles.appBodyText,
            ),
  );
}
