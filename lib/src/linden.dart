import 'package:flutter/material.dart';
import 'xanimations.dart';
import 'xassets.dart';
import 'xcolors.dart';
import 'xsizes.dart';
import 'xstyles.dart';

/// [Linden] is a design class that provide shared stylistic design elements
/// including:
///  1. [Duration]s for [animations] by configuring [XAnimations]
///
///  2. [XStyles] is configured for [styles] to provide various [TextStyle]s and other style
///  related objects.
///
///  3. [ThemeData] is configured and exposed as [themeData]
///
///  4. All the shared [assets] are exposed under [XAssets]
///
///  5. Shared [dimen] is a configuration of [XSizes] and it's affected by
///  the size of the screen and the [Platform]
///
///  6. Material [Colors] are exposed as [colors] and configured by utilizing
///  [XColors]
///
/// {@tool snippet}
/// This example shows how to create a [Linden] that defines a [theme] that
/// will be used for material widgets in the app.
///
/// ```dart
/// final linden = Linden();
///   @override
///   Widget build(BuildContext context) {
///    return MaterialApp(
///      title: 'Flutter Demo',
///      theme: linden.themeData,
///      home: Container(),
///    );
///   }
/// ```
/// {@end-tool}
///
@immutable
class Linden {
  Linden({
    this.screenSize,
    this.deviceOrientation = Orientation.portrait,
    this.notchPaddingLandscapeMode = 0,
    this.brightness = Brightness.light,
    this.animations = const XAnimations(),
    XSizes? dimen,
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
        themeData = themeData ?? _defaultTheme(brightness, styles: styles),
        dimen = dimen ??
            XSizes(
              notchPaddingLandscapeMode: notchPaddingLandscapeMode,
              deviceOrientation: deviceOrientation,
              screenSize: screenSize,
            );

  /// Responsible for the screen size and eventually updates the [XSizes]
  /// instance, dimen, when altered.
  ///
  final Size? screenSize;

  /// Passes the state of the device orientation and updates the [XSizes]
  /// instance, dimen, when altered.
  ///
  final Orientation deviceOrientation;

  /// When in landscape mode, regardless of the orientation; left or right,
  /// if there is a notch both [Padding.right] and [Padding.left] return the
  /// notch padding value.
  ///
  /// It updates the [XSizes] instance, dimen, when altered.
  ///
  final double notchPaddingLandscapeMode;

  /// Responsible for switching theme from light to dark and vise versa.
  ///
  /// default value is [Brightness.light]
  ///
  final Brightness brightness;

  /// Responsible for TextStyles in the app as well as any other shared
  /// [Material] style we use in the design system.
  ///
  final XStyles styles;

  /// Provides theme configuration for Linden and in case nothing is passed,
  /// the private [_defaultTheme] is used.
  ///
  final ThemeData themeData;

  /// All the dimensions is the responsibility of dimen. It's dependent on
  /// the configuration pf XSizes class.
  ///
  final XSizes dimen;

  /// The shared colors configuration.
  ///
  final XColors colors;

  /// Assets' configuration.
  ///
  final XAssets assets;

  /// Animations' parameters, mostly [Duration]s, configurations.
  ///
  final XAnimations animations;

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  ///
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

  /// Update all the dimension configuration of [XSizes] in [Linden]
  ///
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

  /// Update theme to light/dark mode
  ///
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

/// Default private configuration of [ThemeData]
///
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
