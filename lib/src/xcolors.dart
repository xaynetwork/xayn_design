import 'package:flutter/material.dart';

@immutable
class XColors {
  final Brightness _brightness;
  const XColors({Brightness? brightness})
      : _brightness = brightness ?? Brightness.light;

  /// Private Colors never use directly
  // Primary colors
  static const _blue = Color(0xff233564);
  static const _black = Color(0xff131313);
  static const _trueBlack = Color(0xff000000);
  static const _black29 = Color(0xff292929);
  static const _black33 = Color(0xff333333);
  static const _green = Color(0xff22A186);

  // Secondary Colors
  static const _lightGreen = Color(0xff79cec0);
  static const _lightGrey = Color(0xfff0f0f0);
  static const _mediumGrey = Color(0xffc4c4c4);
  static const _darkGrey = Color(0xff787878);
  static const _pink = Color(0xffE51674);
  static const _purple = Color(0xff524897);
  static const _orange = Color(0xffF29100);
  static const _white = Color(0xffffffff);

  /// This is the only non semantic public color, for convenience
  static const _transparent = Color(0x00000000);

  /// Public color aliases
  /// Introduce general colors here,
  /// create a new one if you are unable to find a semantically matching name
  /// for your use case.
  /// Try to keep naming as general as possible
  Color get primary => _theme(bright: _blue, dark: _white);
  Color get accent => _theme(bright: _green);
  Color get secondaryAccent => _theme(bright: _orange);
  Color get primaryText => _theme(bright: _black, dark: _lightGrey);
  Color get secondaryText => _theme(bright: _darkGrey);
  Color get tertiaryText => _theme(bright: _mediumGrey);
  Color get tooltipText => _theme(bright: _blue, dark: _white);
  Color get icon => _theme(bright: _black, dark: _white);
  Color get iconDisabled => _theme(bright: _mediumGrey, dark: _darkGrey);
  Color get iconSelected => _theme(bright: _green);
  Color get iconInverse => _theme(bright: _white);
  Color get iconBackground => _theme(bright: _lightGrey, dark: _black);
  Color get iconBackgroundSelected => _theme(bright: _white, dark: _white);
  Color get secondaryIcon => _theme(bright: _blue);

  Color get primaryTextInverse => _theme(bright: _white, dark: _black);
  Color get pageBackground => _theme(bright: _white, dark: _black29);
  Color get cardBackground => _theme(bright: _white, dark: _black33);
  Color get background => _theme(bright: _white, dark: _black);
  Color get videoBackground => _theme(bright: _black);
  Color get tooltipBackground => _theme(bright: _white, dark: _black);
  Color get hintTextStyle => _theme(bright: _darkGrey, dark: _mediumGrey);

  Color get imageBackground => _theme(bright: _white);
  Color get imageBackgroundOverlay => imageBackground.withAlpha(200);
  Color get imageDetailsBackground => _theme(bright: _trueBlack).withAlpha(120);
  Color get imagePreviewBackground => _theme(bright: _trueBlack);

  Color get secondaryActionText => _theme(bright: _mediumGrey);
  Color get divider => _theme(bright: _mediumGrey);
  Color get shadow => _theme(bright: _darkGrey);
  Color get searchSuggetsionShadow => _theme(bright: _black.withAlpha(20));
  Color get searchSuggestion => _theme(bright: _lightGreen);
  Color get shadowTransparent =>
      _theme(bright: _black.withAlpha(65), dark: _black.withAlpha(0));
  Color get shadowTransparentDarker =>
      _theme(bright: _black.withAlpha(100), dark: _black.withAlpha(0));
  Color get transparent => _transparent;
  Color get searchInputFill => _theme(bright: _lightGrey, dark: _black33);
  Color get searchInputText => _theme(bright: _black, dark: _lightGrey);
  Color get searchInputTextDisabled =>
      _theme(bright: _mediumGrey, dark: _darkGrey);
  Color get searchPuller => _theme(bright: _mediumGrey);
  Color get searchResultSkeletonBase => _theme(bright: _mediumGrey);
  Color get searchResultSkeletonHighlight => _theme(bright: _lightGrey);
  Color get cardTitle => _theme(bright: _black, dark: _lightGrey);
  Color get cardCaption => _theme(bright: _mediumGrey);
  Color get cardBorderHighlight => _theme(bright: _green);
  Color get imagePlaceholderBackground => _theme(bright: _mediumGrey);
  Color get swipeBackgroundRelevant => _theme(bright: _green);
  Color get swipeBackgroundNeutral => _theme(bright: _mediumGrey);
  Color get swipeBackgroundBookmark => _theme(bright: _purple);
  Color get swipeBackgroundMoveBookmark => _theme(bright: _purple);
  Color get swipeBackgroundEdit => _theme(bright: _purple);
  Color get swipeBackgroundShare => _theme(bright: _white);
  Color get swipeBackgroundIrrelevant => _theme(bright: _pink);
  Color get swipeBackgroundDelete => _theme(bright: _pink);
  Color get overlayBackground => _theme(bright: _black.withAlpha(96));
  Color get searchInputBarShadowBackground =>
      _theme(bright: primary.withAlpha(10));
  Color get snackbarBackground => _theme(bright: _blue.withAlpha(227));
  Color get placeholderIcon => _theme(bright: _mediumGrey);
  Color get autosuggestionMarketChange => _theme(bright: _purple);
  Color get imageBlurColor => _theme(bright: _white.withOpacity(0.333));

  Color? get logo => _themeDarkModeColorOrNull(dark: _white);

  /// Colors that are independent of the dark mode

  Color get onboardingBackground => _white;
  Color get onboardingTextSelected => _green;
  Color get onboardingTextInverse => _white;
  Color get onboardingTagTextInverse => _white;
  Color get onboardingSelectedTagBackground => _purple;
  Color get onboardingTagBackground => _white;
  Color get onboardingSearchInputFill => _lightGrey;
  Color get checkboxUnchecked => _lightGrey;
  Color get checkboxChecked => _green;

  Color get speedDialText => _black;
  Color get brightText => _white;
  Color get brightIcon => _white;
  Color get darkIcon => _blue;
  Color get primaryAction => _pink;
  Color get inputErrorText => _pink;

  Color get webViewBottomBarActionBackground => _purple;

  Color get speedDialButtonSelected => _pink;
  Color get speedDialButtonUnSelected => _lightGrey;

  Color get qrCodeBackground => _white;

  //
  // Color helper constants
  //
  final alpha50 = 0x7f;
  Color _theme({
    required Color bright,
    Color? dark,
  }) {
    final darkBrightness = dark ?? bright;
    return brightness == Brightness.dark ? darkBrightness : bright;
  }

  Color? _themeDarkModeColorOrNull({
    required Color dark,
  }) =>
      brightness == Brightness.dark ? dark : null;

  Brightness get brightness => _brightness;
}
