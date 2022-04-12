import 'package:flutter/material.dart';

/// The [XColors] holds different Material `Color`s
///
/// Accessed through [Linden].
@immutable
class XColors {
  final Brightness _brightness;

  const XColors._({Brightness? brightness})
      : _brightness = brightness ?? Brightness.light;

  factory XColors({
    required Brightness? brightness,
  }) =>
      XColors._(brightness: brightness);

  static const _XaynAccentColor _green = _XaynAccentColor(
    _greenPrimaryValue,
    <int, Color>{
      20: Color(0xFFCCE6E2),
      40: Color(0xFF99CEC5),
      60: Color(0xFF66B5A7),
      80: Color(0xFF339D8A),
      100: Color(_greenPrimaryValue),
      120: Color(0xFF006B58),
    },
  );
  static const int _greenPrimaryValue = 0xFF00856D;

  static const _XaynAccentColor _pink = _XaynAccentColor(
    _pinkPrimaryValue,
    <int, Color>{
      20: Color(0xFFF3CDDE),
      40: Color(0xFFEDA0C3),
      60: Color(0xFFE772A7),
      80: Color(0xFFE1458B),
      100: Color(_pinkPrimaryValue),
      120: Color(0xFFC21563),
    },
  );
  static const int _pinkPrimaryValue = 0xFFDB1870;

  static const _XaynAccentColor _purple = _XaynAccentColor(
    _purplePrimaryValue,
    <int, Color>{
      20: Color(0xFFDDDBEA),
      40: Color(0xFFBBB6D6),
      60: Color(0xFF9892C1),
      80: Color(0xFF766DAD),
      100: Color(_purplePrimaryValue),
      120: Color(0xFF463D80),
    },
  );
  static const int _purplePrimaryValue = 0xFF544998;

  static const _XaynAccentColor _orange = _XaynAccentColor(
    _orangePrimaryValue,
    <int, Color>{
      20: Color(0xFFFCE9CD),
      40: Color(0xFFF9D39B),
      60: Color(0xFFF6BC69),
      80: Color(0xFFF3A637),
      100: Color(_orangePrimaryValue),
      120: Color(0xFFD68004),
    },
  );
  static const int _orangePrimaryValue = 0xFFF09005;

  static const _XaynGreyScale _grey = _XaynGreyScale(
    _greyPrimaryValue,
    <int, Color>{
      5: Color(0xFFF8F8F8),
      10: Color(0xFFE2E4E4),
      20: Color(0xFFCACDCD),
      40: Color(_greyPrimaryValue),
      60: Color(0xFF6D7372),
      80: Color(0xFF3E4645),
      95: Color(0xFF1B2524),
    },
  );
  static const int _greyPrimaryValue = 0xFF9BA0A0;

  /// Private Colors never use directly
  static const _black = Color(0xff0F1A18);
  static const _trueBlack = Color(0xff000000);
  static const _white = Color(0xffffffff);
  static const _beige = Color(0xfff8f0e3);

  /// This is the only non semantic public color, for convenience
  static const _transparent = Color(0x00000000);

  /// Public color aliases
  // Introduce general colors here,
  // create a new one if you are unable to find a semantically matching name
  // for your use case.
  // Try to keep naming as general as possible
  Color get primary => _theme(bright: _green);

  Color get accent => _theme(bright: _green);

  Color get secondaryAccent => _theme(bright: _orange);

  Color get primaryText => _theme(bright: _black, dark: _white);

  Color get secondaryText => _theme(bright: _grey.shade60, dark: _grey.shade20);

  Color get tertiaryText => _theme(bright: _grey);

  Color get quaternaryText => _theme(bright: _white);

  Color get tooltipText => _theme(bright: _black, dark: _white);

  Color get icon => _theme(bright: _black, dark: _grey.shade20);

  Color get iconDisabled => _theme(bright: _grey, dark: _grey.shade60);

  Color get iconSelected => _theme(bright: _green);

  Color get iconInverse => _theme(bright: _white);

  Color get iconBackground => _theme(bright: _white, dark: _grey.shade95);

  Color get iconBackgroundSelected => _theme(bright: _white, dark: _white);

  Color get primaryTextInverse => _theme(bright: _white, dark: _black);

  Color get pageBackground => _theme(bright: _white, dark: _grey.shade95);

  Color get homePageBackground => _theme(bright: _white, dark: _grey.shade80);

  Color get cardBackground => _theme(bright: _white, dark: _grey.shade80);

  Color get background => _theme(bright: _white, dark: _black);

  Color get videoBackground => _theme(bright: _black);

  Color get tooltipBackground => _theme(bright: _white, dark: _black);

  Color get hintTextStyle => _theme(bright: _grey.shade60, dark: _grey);

  Color get imageBackground => _theme(bright: _white);

  Color get imageBackgroundOverlay => imageBackground.withAlpha(200);

  Color get imageDetailsBackground => _theme(bright: _trueBlack).withAlpha(120);

  Color get imagePreviewBackground => _theme(bright: _trueBlack);

  Color get secondaryActionText => _theme(bright: _grey);

  Color get divider => _theme(bright: _grey);

  Color get shadow => _theme(bright: _grey.shade60);

  Color get searchSuggetsionShadow => _theme(bright: _black.withAlpha(20));

  Color get searchSuggestion => _theme(bright: _green.shade60);

  Color get inputTextFieldBorderColor =>
      _theme(bright: _grey.shade20, dark: _grey.shade80);

  Color get shadowTransparent =>
      _theme(bright: _black.withAlpha(65), dark: _black.withAlpha(0));

  Color get shadowTransparentLigher =>
      _theme(bright: _black.withAlpha(24), dark: _transparent);

  Color get shadowTransparentDarker =>
      _theme(bright: _black.withAlpha(100), dark: _black.withAlpha(0));

  Color get transparent => _transparent;

  Color get searchInputFill =>
      _theme(bright: _grey.shade10, dark: _grey.shade80);

  Color get searchInputText => _theme(bright: _black, dark: _grey.shade10);

  Color get searchInputTextDisabled =>
      _theme(bright: _grey, dark: _grey.shade60);

  Color get searchPuller => _theme(bright: _grey);

  Color get searchResultSkeletonBase => _theme(bright: _grey);

  Color get searchResultSkeletonHighlight => _theme(bright: _grey.shade10);

  Color get cardTitle => _theme(bright: _black, dark: _grey.shade10);

  Color get cardCaption => _theme(bright: _grey);

  Color get cardBorderHighlight => _theme(bright: _green);

  Color get imagePlaceholderBackground => _theme(bright: _grey);

  Color get swipeBackgroundRelevant => _theme(bright: _green);

  Color get swipeBackgroundNeutral => _theme(bright: _grey);

  Color get swipeBackgroundBookmark => _theme(bright: _purple);

  Color get swipeBackgroundMoveBookmark => _theme(bright: _purple);

  Color get swipeBackgroundEdit => _theme(bright: _purple);

  Color get swipeBackgroundShare => _theme(bright: _white);

  Color get swipeBackgroundIrrelevant => _theme(bright: _pink);

  Color get swipeBackgroundDelete => _theme(bright: _pink);

  Color get overlayBackground => _theme(bright: _black.withAlpha(96));

  Color get searchInputBarShadowBackground =>
      _theme(bright: primary.withAlpha(10));

  Color get placeholderIcon => _theme(bright: _grey);

  Color get autosuggestionMarketChange => _theme(bright: _purple);

  Color get imageBlurColor => _theme(bright: _white.withOpacity(0.333));

  Color? get logo => _themeDarkModeColorOrNull(dark: _white);

  Color get bottomSheetCancelBackgroundColor => _theme(
        bright: _grey.shade5,
        dark: _grey.shade80,
      );

  /// Colors that are independent of the dark mode
  Color get connectionErrorBackground => _pink.shade20;

  Color get connectionErrorText => _pink.shade100;

  Color get onboardingBackground => _white;

  Color get onboardingTutorialBackground => _black.withOpacity(0.85);

  Color get onboardingTextSelected => _green;

  Color get onboardingTextInverse => _white;

  Color get onboardingTagTextInverse => _white;

  Color get onboardingSelectedTagBackground => _purple;

  Color get onboardingTagBackground => _white;

  Color get onboardingSearchInputFill => _grey.shade10;

  Color get checkboxUnchecked => _grey.shade10;

  Color get checkboxChecked => _green;

  Color get speedDialText => _black;

  Color get brightText => _white;

  Color get brightIcon => _white;

  Color get primaryAction => _pink;

  Color get inputErrorText => _pink;

  Color get webViewBottomBarActionBackground => _purple;

  Color get speedDialButtonSelected => _pink;

  Color get speedDialButtonUnSelected => _grey.shade10;

  Color get qrCodeBackground => _white;

  Color get swipeCardBackgroundDefault => _black;

  Color get swipeCardBackgroundHome => _grey.shade95;

  Color get snippetBackground => _white;

  Color get snippetTextColor => _black;

  /// Dots indicator
  Color get dotsIndicatorColor => _transparent;

  Color get dotsIndicatorActiveColor => _white;

  Color get dotsIndicatorBorderColor => _white;

  Color get bottomSheetBackgroundColor =>
      _theme(bright: _white, dark: _grey.shade95);

  Color get bottomSheetBarrierColor =>
      _theme(bright: _white, dark: _grey.shade80).withOpacity(0.8);

  Color get selectedItemBackgroundColor => _theme(bright: _green.shade120);

  Color get readerModeBeigeBackgroundColor => _theme(bright: _beige);

  Color get readerModeWhiteBackgroundColor => _theme(bright: _white);

  Color get readerModeDarkBackgroundColor => _theme(bright: _grey.shade95);

  Color get readerModeBlackBackgroundColor => _theme(bright: _trueBlack);

  Color get menuDividerColor =>
      _theme(bright: _grey.shade10, dark: _grey.shade80);

  Color get chipBorderColor => _theme(bright: _grey.shade20);

  Color get readerModeTextDarkColor => _theme(bright: _black);

  Color get readerModeTextWhiteColor => _theme(bright: _white);

  Color get readerModeSettingsErrorBackgroundColor =>
      _theme(bright: _pink.shade20);

  Color get readerModeSettingsErrorTextColor => _theme(bright: _pink);

  /// Color helper constants
  final alpha50 = 0x7f;

  Color getNavBarIconColor({
    bool isActive = false,
  }) =>
      isActive
          ? _theme(bright: _green.shade100, dark: _green.shade80)
          : _theme(bright: _grey.shade80, dark: _grey.shade10);

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
  Color get splashColor => _theme(bright: _grey.shade20.withOpacity(0.5));

  Color get settingsIcon => _theme(bright: _black, dark: _white);

  Color get settingsCardBackground =>
      _theme(bright: _grey.shade5, dark: _grey.shade80);

  Color get personalAreaCollections => _orange.shade80;

  Color get personalAreaHomeFeed => _theme(bright: _green.shade80);

  Color get personalAreaSettings => _purple.shade80;

  Color get collectionsScreenCard => _pink.shade60;
//endregion colors, needed for new scheme
}

class _XaynAccentColor extends ColorSwatch<int> {
  const _XaynAccentColor(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  Color get shade20 => this[20]!;

  Color get shade40 => this[40]!;

  Color get shade60 => this[60]!;

  Color get shade80 => this[80]!;

  Color get shade100 => this[100]!;

  Color get shade120 => this[120]!;
}

class _XaynGreyScale extends ColorSwatch<int> {
  const _XaynGreyScale(int primary, Map<int, Color> swatch)
      : super(primary, swatch);

  Color get shade5 => this[5]!;

  Color get shade10 => this[10]!;

  Color get shade20 => this[20]!;

  Color get shade30 => this[30]!;

  Color get shade40 => this[40]!;

  Color get shade60 => this[60]!;

  Color get shade80 => this[80]!;

  Color get shade95 => this[95]!;
}
