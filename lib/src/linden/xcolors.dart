import 'package:flutter/material.dart';

/// The [XColors] holds different Material `Color`s
///
/// Accessed through [Linden].
@immutable
class XColors {
  final Brightness _brightness;

  const XColors._({Brightness? brightness})
      : _brightness = brightness ?? Brightness.light;

  factory XColors(
    bool newScheme, {
    Brightness? brightness,
  }) =>
      newScheme
          ? NewXColors(brightness: brightness)
          : XColors._(brightness: brightness);

  /// Private Colors never use directly
  // Primary colors
  static const _blue = Color(0xff233564);
  static const _black = Color(0xff131313);
  static const _trueBlack = Color(0xff000000);
  static const _black29 = Color(0xff292929);
  static const _black33 = Color(0xff333333);
  static const _black10 = Color(0xffE2E4E4);
  static const _black20 = Color(0xffCACDCD);
  static const _darkGreen = Color(0xff00856D);
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
  static const _beige = Color(0xfff8f0e3);

  /// This is the only non semantic public color, for convenience
  static const _transparent = Color(0x00000000);

  /// Public color aliases
  // Introduce general colors here,
  // create a new one if you are unable to find a semantically matching name
  // for your use case.
  // Try to keep naming as general as possible
  Color get primary => _theme(bright: _blue, dark: _white);

  Color get accent => _theme(bright: _green);

  Color get secondaryAccent => _theme(bright: _orange);

  Color get primaryText => _theme(bright: _black, dark: _lightGrey);

  Color get secondaryText => _theme(bright: _darkGrey);

  Color get tertiaryText => _theme(bright: _mediumGrey);

  Color get tooltipText => _theme(bright: _blue, dark: _white);

  Color get icon => _theme(bright: _blue, dark: _white);

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

  Color get shadowTransparentLigher =>
      _theme(bright: _black.withAlpha(24), dark: _transparent);

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

  Color get onboardingTutorialBackground => _black.withOpacity(0.85);

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

  Color get swipeCardBackground => _black;

  Color get snippetBackground => _white;

  Color get snippetTextColor => _black;

  /// Dots indicator
  Color get dotsIndicatorColor => _transparent;

  Color get dotsIndicatorActiveColor => _white;

  Color get dotsIndicatorBorderColor => _white;

  Color get bottomSheetBackgroundColor =>
      _theme(bright: _white, dark: _black29);

  Color get bottomSheetBarrierColor =>
      _theme(bright: _white, dark: _black).withOpacity(0.8);

  Color get selectedItemBackgroundColor => _theme(bright: _darkGreen);

  Color get readerModeBeigeBackgroundColor => _theme(bright: _beige);

  Color get readerModeWhiteBackgroundColor => _theme(bright: _white);

  Color get readerModeBlackBackgroundColor => _theme(bright: _black29);

  Color get menuDividerColor => _theme(bright: _black10, dark: _black33);

  Color get chipBorderColor => _theme(bright: _black20);

  Color get readerModeTextDarkColor => _theme(bright: _black);

  Color get readerModeTextWhiteColor => _theme(bright: _white);

  /// Color helper constants
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

  //region colors, needed for new scheme
  Color get splashColor => _theme(bright: _mediumGrey.withOpacity(0.5));

  Color get settingsIcon => throw _NewSchemeException();

  Color get settingsCardBackground => throw _NewSchemeException();

  Color get personalAreaCollections => throw _NewSchemeException();

  Color get personalAreaHomeFeed => throw _NewSchemeException();

  Color get personalAreaSettings => throw _NewSchemeException();

  Color get collectionsScreenCard => throw _NewSchemeException();
//endregion colors, needed for new scheme
}

/// right now we are in the middle of the design migration.
/// So far I added here some items, which I need for my tasks.
/// But later we will restructure all this file with proper items (names and structure)
class NewXColors extends XColors {
  const NewXColors({
    Brightness? brightness,
  }) : super._(brightness: brightness);

  // Primary colors
  static const _primary = Color(0xff009278);

  // ignore: unused_field
  static const _primary20 = Color(0xffCCE6E2);

  // ignore: unused_field
  static const _primary40 = Color(0xff99CEC5);

  // ignore: unused_field
  static const _primary60 = Color(0xff66B5A7);

  // ignore: unused_field
  static const _primary80 = Color(0xff339D8A);

  // ignore: unused_field
  static const _primary120 = Color(0xff006B58);

  /// Grey Scale
  static const _white = Color(0xffFFFFFF);
  static const _black = Color(0xff0F1A18);
  static const _black5 = Color(0xffF8F8F8);

  // ignore: unused_field
  static const _black10 = Color(0xffE2E4E4);
  static const _black20 = Color(0xffCACDCD);

  // ignore: unused_field
  static const _black40 = Color(0xff9BA0A0);
  static const _black60 = Color(0xff6D7372);
  static const _black80 = Color(0xff3E4645);
  static const _black95 = Color(0xff1B2524);

  /// Accent Pink
  // ignore: unused_field
  static const _pink = Color(0xffDB1870);

  // ignore: unused_field
  static const _pink20 = Color(0xffF3CDDE);

  // ignore: unused_field
  static const _pink40 = Color(0xffEDA0C3);

  // ignore: unused_field
  static const _pink60 = Color(0xffE772A7);

  // ignore: unused_field
  static const _pink80 = Color(0xffE1458B);

  // ignore: unused_field
  static const _pink120 = Color(0xffC21563);

  /// Accent Purple
  // ignore: unused_field
  static const _purple = Color(0xff544998);

  // ignore: unused_field
  static const _purple20 = Color(0xffDDDBEA);

  // ignore: unused_field
  static const _purple40 = Color(0xffBBB6D6);

  // ignore: unused_field
  static const _purple60 = Color(0xff9892C1);

  // ignore: unused_field
  static const _purple80 = Color(0xff766DAD);

  // ignore: unused_field
  static const _purple120 = Color(0xff463D80);

  /// Accent Orange
  // ignore: unused_field
  static const _orange = Color(0xffF09005);

  // ignore: unused_field
  static const _orange20 = Color(0xffFCE9CD);

  // ignore: unused_field
  static const _orange40 = Color(0xffF9D39B);

  // ignore: unused_field
  static const _orange60 = Color(0xffF6BC69);

  // ignore: unused_field
  static const _orange80 = Color(0xffF3A637);

  // ignore: unused_field
  static const _orange120 = Color(0xffD68004);

  @override
  Color get primary => _theme(bright: _primary);

  @override
  Color get splashColor => _theme(bright: _black20.withOpacity(0.5));

  @override
  Color get primaryText => _theme(bright: _black, dark: _white);

  @override
  Color get primaryTextInverse => _theme(bright: _white);

  @override
  Color get secondaryText => _theme(bright: _black60, dark: _black20);

  @override
  Color get background => _theme(bright: _white, dark: _black);

  @override
  Color get icon => _theme(bright: _black, dark: _black20);

  @override
  Color get iconBackground => _theme(bright: _white, dark: _black95);

  @override
  Color get settingsIcon => _theme(bright: _black, dark: _white);

  @override
  Color get settingsCardBackground => _theme(bright: _black5, dark: _black80);

  @override
  Color get personalAreaCollections => _theme(bright: _orange80);

  @override
  Color get personalAreaHomeFeed => _theme(bright: _primary80);

  @override
  Color get personalAreaSettings => _theme(bright: _purple80);

  @override
  Color get collectionsScreenCard => _theme(bright: _pink60);
}

class _NewSchemeException implements Exception {
  @override
  String toString() => 'This color supported only with the new color scheme';
}
