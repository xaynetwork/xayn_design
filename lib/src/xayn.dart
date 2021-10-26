import 'package:flutter/material.dart';
import 'animations.dart';
import 'assets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

@immutable
class Xayn {
  Xayn({
    TextTheme? textTheme,
    this.screenSize,
    this.deviceOrientation = Orientation.portrait,
    this.notchPaddingLandscapeMode = 0,
    this.brightness = Brightness.light,
    XStyles? styles,
    ThemeData? themeData,
    this.dimen = const XSizes(),
    this.animations = const Animations(),
    XColors? colors,
    Assets? assets,
  })  : assets = assets ?? Assets(brightness: brightness),
        colors = colors ?? XColors(brightness: brightness),
        textTheme = textTheme ?? Typography.material2018().white,
        styles = styles ??= XStyles(
          defaultTheme(brightness).textTheme,
          brightness: brightness,
        ),
        themeData = themeData ?? defaultTheme(brightness, styles: styles);

  final TextTheme textTheme;
  final Size? screenSize;
  final Orientation deviceOrientation;
  final double notchPaddingLandscapeMode;
  final Brightness brightness;
  final XStyles styles;
  final ThemeData themeData;
  final XSizes dimen;
  final XColors colors;
  final Assets assets;
  final Animations animations;

  bool get isDarkMode => brightness == Brightness.dark;

  Xayn copyWith({
    TextTheme? textTheme,
    Size? screenSize,
    Orientation? deviceOrientation,
    double? notchPaddingLandscapeMode,
    Brightness? brightness,
    XStyles? styles,
    ThemeData? themeData,
    XSizes? dimen,
    XColors? colors,
    Assets? assets,
    Animations? animations,
  }) =>
      Xayn(
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

  Xayn updateBaseTextTheme(TextTheme textTheme) {
    final styles = XStyles(
      textTheme,
      brightness: brightness,
    );
    return copyWith(
      textTheme: textTheme,
      styles: styles,
      themeData: defaultTheme(brightness, styles: styles),
    );
  }

  Xayn updateScreenInfo({
    required Size screenSize,
    required Orientation deviceOrientation,
    double notchPaddingLandscapeMode = 0.0,
  }) {
    if (screenSize != this.screenSize ||
        deviceOrientation != this.deviceOrientation ||
        notchPaddingLandscapeMode != this.notchPaddingLandscapeMode) {
      final newXayn = copyWith(
        screenSize: screenSize,
        deviceOrientation: deviceOrientation,
        notchPaddingLandscapeMode: notchPaddingLandscapeMode,
        dimen: XSizes(
          screenSize: screenSize,
          deviceOrientation: deviceOrientation,
          notchPaddingLandscapeMode: notchPaddingLandscapeMode,
        ),
      );
      return newXayn;
    }
    return this;
  }

  Xayn updateBrightness(Brightness brightness) {
    return copyWith(
      brightness: brightness,
      colors: XColors(brightness: brightness),
      assets: Assets(brightness: brightness),
      styles: XStyles(textTheme, brightness: brightness),
      themeData: defaultTheme(brightness, styles: styles),
    );
  }

  static ThemeData defaultTheme(Brightness brightness, {XStyles? styles}) {
    final colors = XColors(brightness: brightness);
    return ThemeData(
      fontFamily: 'NotoSans',
      brightness: brightness,
      primaryColor: colors.primary,
      // ignore: deprecated_member_use
      accentColor: colors.accent,
      // ignore: deprecated_member_use
      buttonColor: colors.primaryAction,
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
          : defaultTheme(brightness).textTheme.copyWith(
                subtitle1: styles.appHighlightText,
                bodyText1: styles.appBodyText,
              ),
    );
  }

  static TextTheme defaultTextTheme(Brightness brightness) =>
      defaultTheme(brightness).textTheme;
}
