import 'package:flutter/material.dart';
import 'xanimations.dart';
import 'xassets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

@immutable
class Linden {
  Linden({
    TextTheme? textTheme,
    this.screenSize,
    this.deviceOrientation = Orientation.portrait,
    this.notchPaddingLandscapeMode = 0,
    this.brightness = Brightness.light,
    XStyles? styles,
    ThemeData? themeData,
    this.dimen = const XSizes(),
    this.animations = const XAnimations(),
    XColors? colors,
    XAssets? assets,
  })  : assets = assets ?? XAssets(brightness: brightness),
        colors = colors ?? XColors(brightness: brightness),
        textTheme = textTheme ?? Typography.material2018().white,
        styles = styles ??= XStyles(
          _defaultTheme(brightness).textTheme,
          brightness: brightness,
        ),
        themeData = themeData ?? _defaultTheme(brightness, styles: styles);

  final TextTheme textTheme;
  final Size? screenSize;
  final Orientation deviceOrientation;
  final double notchPaddingLandscapeMode;
  final Brightness brightness;
  final XStyles styles;
  final ThemeData themeData;
  final XSizes dimen;
  final XColors colors;
  final XAssets assets;
  final XAnimations animations;

  Linden copyWith({
    TextTheme? textTheme,
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
        textTheme: textTheme ?? this.textTheme,
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

  Linden updateBaseTextTheme(TextTheme textTheme) {
    final styles = XStyles(
      textTheme,
      brightness: brightness,
    );
    return copyWith(
      textTheme: textTheme,
      styles: styles,
      themeData: _defaultTheme(brightness, styles: styles),
    );
  }

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
        styles: XStyles(textTheme, brightness: brightness),
        themeData: _defaultTheme(brightness, styles: styles),
      );

  static ThemeData _defaultTheme(Brightness brightness, {XStyles? styles}) {
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

  static TextTheme defaultTextTheme(Brightness brightness) =>
      _defaultTheme(brightness).textTheme;
}
