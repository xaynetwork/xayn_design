import 'package:flutter/material.dart';

import 'xcolors.dart';
import 'xsizes.dart';

const _kNotoSerifFontFamily = 'NotoSerif';
const _kNotoSansFontFamily = 'NotoSans';

/// The [XStyles] holds `TextStyle`s and other Material themed styles
///
/// Accessed through [Linden].
@immutable
class XStyles {
  final XColors colors;

  XStyles(
    this.colors, {
    Brightness? brightness,
  });

  FontWeight get _weightBold => FontWeight.w700;

  FontWeight get _weightRegular => FontWeight.w400;

  /// New styles
  TextStyle get xxlBoldStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 28,
        // height = 40
        height: 1.43,
        fontWeight: _weightBold,
      );

  TextStyle get xlBoldStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 24,
        // height = 32
        height: 1.33,
        fontWeight: _weightBold,
      );

  TextStyle get lBoldStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 18,
        // height = 24
        height: 1.33,
        fontWeight: _weightBold,
      );

  TextStyle get lStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 18,
        // height = 24
        height: 1.33,
        fontWeight: _weightRegular,
      );

  TextStyle get mBoldStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 14,
        // height = 20
        height: 1.43,
        fontWeight: _weightBold,
      );

  TextStyle get mStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 14,
        // height = 20
        height: 1.43,
        fontWeight: _weightRegular,
      );

  TextStyle get sBoldStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 10,
        // height = 16
        height: 1.6,
        fontWeight: _weightBold,
      );

  TextStyle get sStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 10,
        // height = 16
        height: 1.6,
        fontWeight: _weightRegular,
      );

  TextStyle get lHighDensityStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 16,
        // height = 28
        height: 1.75,
        fontWeight: _weightRegular,
      );

  TextStyle get mHighDensityStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 14,
        // height = 24
        height: 1.71,
        fontWeight: _weightRegular,
      );

  TextStyle get sHighDensityStyle => TextStyle(
        fontFamily: _kNotoSansFontFamily,
        color: colors.primaryText,
        fontSize: 12,
        // height = 20
        height: 1.67,
        fontWeight: _weightRegular,
      );

  /// Defined by design
  TextStyle get appScreenHeadline => xlBoldStyle;

  TextStyle get appHeadlineText => lBoldStyle;

  TextStyle get appSmallHeadlineText => mBoldStyle;

  TextStyle get appHighlightText => lStyle;

  TextStyle get appBodyText => mStyle;

  TextStyle get appBodyTextSecondary => mStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get appButtonText => mBoldStyle;

  TextStyle get appLinkText => sBoldStyle.copyWith(
        decoration: TextDecoration.underline,
        color: colors.secondaryText,
      );

  TextStyle get bottomSheetText => mBoldStyle;

  TextStyle get appSecondaryButtonText => mBoldStyle.copyWith(
        color: colors.secondaryActionText,
      );

  TextStyle get appThumbnailText => sBoldStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get appCaptionText => sStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get settingsLayoutSectionText => sBoldStyle;

  TextStyle get settingsLayoutSectionTextSelected => sBoldStyle.copyWith(
        color: colors.primaryTextInverse,
      );

  TextStyle get appThumbnailTextLight => sStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get textInputText => mStyle.copyWith(
        color: colors.searchInputText,
      );

  TextStyle get textInputHint => mStyle.copyWith(
        color: colors.hintTextStyle,
      );

  TextStyle get textInputError => mStyle.copyWith(
        color: colors.inputErrorText,
      );

  TextStyle get textInputErrorSmall => sStyle.copyWith(
        color: colors.inputErrorText,
      );

  TextStyle get notoSerifFontText => const TextStyle(
        fontFamily: _kNotoSerifFontFamily,
      );

  TextStyle get notoSansFontText => const TextStyle(
        fontFamily: _kNotoSansFontFamily,
      );

  /// Autosuggestion

  TextStyle get chipText => mStyle;

  TextStyle get chipTextBright => appBodyTextBright.copyWith(
        height: 1.2,
      );

  TextStyle get marketButtonStyle => TextStyle(
        color: colors.primaryTextInverse,
        fontSize: 14.0,
      );

  BoxShadow get cardShadow => BoxShadow(
        color: colors.shadowTransparentLigher,
        blurRadius: _dimen.unit1_25,
        spreadRadius: _dimen.unit0_5,
      );

  BoxShadow get suggestionContainerShadow => BoxShadow(
        color: colors.searchSuggetsionShadow,
        blurRadius: 4,
        offset: const Offset(0, 2),
      );

  BoxShadow get webviewShadow => BoxShadow(
        color: colors.shadowTransparent,
        blurRadius: 25,
        spreadRadius: 0,
      );

  /// Domain specific styles, like dialogs, etc

  TextStyle get searchInfoIncludingTerm => appBodyText.copyWith(
        fontWeight: _weightBold,
      );

  TextStyle get searchInfoExplicitTerm => appBodyText.copyWith(
        color: colors.primaryAction,
      );

  TextStyle get dialogTitleText => appHighlightText;

  TextStyle get dialogTitleSmall => dialogTitleText.copyWith(
        fontSize: 16,
      );

  TextStyle get dialogErrorBody => appBodyText.copyWith(
        fontStyle: FontStyle.italic,
        color: colors.primaryText,
      );

  TextStyle get dialogBody => appBodyText.copyWith(
        color: colors.primaryText,
      );

  TextStyle get dialogBodySmall => dialogBody.copyWith(
        fontSize: 10,
      );

  TextStyle get versionText => appHighlightText.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get cardSubtitleText => appThumbnailText.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle get onboardingTitle => appBodyText.copyWith(
        color: colors.primaryText,
        fontSize: 40,
        fontWeight: _weightBold,
      );

  TextStyle get snackBarBrightText => appHighlightText.copyWith(
        color: colors.brightText,
      );

  TextStyle get placeholderText => appHighlightText.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle get placeholderTextSmall => appBodyText.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle get historyButtonText => appBodyText.copyWith(
        color: colors.primaryText,
      );

  /// text styles that are independent of the dark mode

  /// Bright text - used for text within colored boxes like the pixel info in image view
  TextStyle get infoTextBright => appThumbnailTextLight.copyWith(
        color: colors.brightText,
      );

  TextStyle get smallButtonTextBright => appButtonText.copyWith(
        color: colors.brightText,
        fontSize: 10,
      );

  TextStyle get buttonTextBright => appButtonText.copyWith(
        color: colors.brightText,
      );

  TextStyle get appBodyTextBright => appBodyText.copyWith(
        color: colors.brightText,
      );

  TextStyle get webViewBottomMenuTitleText => appBodyText.copyWith(
        fontWeight: _weightBold,
        height: 1,
      );

  TextStyle get webViewBottomMenuUrlText => appBodyText.copyWith(
        height: 1,
      );

  TextStyle get tooltipText => appBodyText.copyWith(
        color: colors.tooltipText,
        fontSize: 13,
        fontWeight: _weightBold,
      );

  TextStyle get tooltipTextStyle => appBodyText.copyWith(
        color: colors.tooltipText,
        fontSize: 13,
        // height = 16
        height: 1.14,
        fontWeight: _weightBold,
      );

  TextStyle get tooltipHighlightTextStyle => tooltipTextStyle.copyWith(
        color: colors.primaryAction,
      );

  TextStyle get tooltipArrowDownTextStyle => appBodyText.copyWith(
        color: colors.brightText,
        fontSize: 18,
        fontWeight: _weightBold,
      );

  TextStyle get betaTagTextStyle => appBodyText.copyWith(
        fontSize: 8,
        fontWeight: _weightBold,
      );

  TextStyle get snippetTextStyle => appBodyText.copyWith(
        fontWeight: FontWeight.w500,
        color: colors.snippetTextColor,
        fontSize: 16,
        height: 2,
      );

  TextStyle get readerModeTextStyle => appBodyText.copyWith(
        fontSize: 15.0,
        fontWeight: _weightRegular,
        height: 1.6,
      );

  TextStyle get subscriptionModalTitle => appBodyText.copyWith(
        fontSize: 18.0,
        fontWeight: _weightRegular,
      );

  TextStyle get subscriptionModalPrice => appBodyText.copyWith(
        fontSize: 28.0,
        fontWeight: _weightBold,
      );

  TextStyle get subscriptionModalPricingDetailsError => appBodyText.copyWith(
        fontSize: 13.0,
        color: colors.inputErrorText,
      );

  TextStyle get subscriptionModalFooter => appBodyText.copyWith(
        fontSize: 10.0,
        fontWeight: _weightRegular,
        color: colors.secondaryText,
      );

  TextStyle get readerModeLargeTextStyle => readerModeTextStyle.copyWith(
        fontSize: 18,
      );

  TextStyle get readerModeSmallTextStyle => readerModeTextStyle.copyWith(
        fontSize: 13,
      );

  TextStyle get readerModeSettingsErrorTextStyle => appBodyText.copyWith(
        fontSize: 10,
        height: 1.14,
        color: colors.readerModeSettingsErrorTextColor,
        fontWeight: _weightBold,
      );

  /// Other styles

  /// Borders generic
  static XSizes get _dimen => const XSizes();

  static double get _unit0_5 => _dimen.unit0_5;

  static double get _unit => _dimen.unit;

  static double get _unit1_5 => _dimen.unit1_5;

  static double get _unit2 => _dimen.unit2;

  static double get _unit2_5 => _dimen.unit2_5;
  final roundBorder = BorderRadius.circular(_unit);
  final roundBorder0_5 = BorderRadius.circular(_unit0_5);
  final roundBorder1_5 = BorderRadius.all(Radius.circular(_unit1_5));
  final roundBorder2_5 = BorderRadius.all(Radius.circular(_unit2_5));

  /// Borders specific

  final roundBorderLarge = BorderRadius.all(Radius.circular(_unit2));

  final roundBorderLargeTopSide = BorderRadius.only(
    topLeft: Radius.circular(_unit2),
    topRight: Radius.circular(_unit2),
  );

  final roundBorderLargeTopLeftRoundedRight = BorderRadius.only(
    topLeft: Radius.circular(_unit2),
    topRight: Radius.circular(_unit),
    bottomRight: Radius.circular(_unit),
  );

  final roundBorderLargeBottomSide = BorderRadius.only(
    bottomLeft: Radius.circular(_unit2),
    bottomRight: Radius.circular(_unit2),
  );

  final roundBorderWebView = BorderRadius.only(
    bottomLeft: Radius.circular(_dimen.unit1_5),
    bottomRight: Radius.circular(_dimen.unit1_5),
  );

  final roundBorderBottomBarMenuSection = BorderRadius.all(
    Radius.circular(_unit),
  );

  final roundBorderSmallBottomSide = BorderRadius.only(
      bottomLeft: Radius.circular(_unit0_5),
      bottomRight: Radius.circular(_unit0_5));

  final roundBorderRightSide =
      BorderRadius.horizontal(right: Radius.circular(_unit));
  final roundBorderLeftSide =
      BorderRadius.horizontal(left: Radius.circular(_unit));

  final zeroBorder = BorderRadius.zero;

  final roundBorderBottomSheet = BorderRadius.only(
    topLeft: Radius.circular(_unit1_5),
    topRight: Radius.circular(_unit1_5),
  );

  final readerModeSettingsErrorBorder = BorderRadius.only(
    topRight: BorderRadius.circular(_unit).topRight,
    topLeft: BorderRadius.circular(_unit).topLeft,
  );

  /// ButtonStyle objects

  ButtonStyle? get historyElevatedButtonStyle => ElevatedButton.styleFrom(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: roundBorder2_5,
        ),
        primary: colors.cardBackground,
      );

  /// Hint text style
  InputDecorationTheme get hintTextDecoration => InputDecorationTheme(
        hintStyle: TextStyle(
          color: colors.hintTextStyle,
        ),
      );

  /// right now we are in the middle of the design migration.
  /// So far I added here some items, which I need for my tasks.
  /// But later we will restructure all this file with proper items (names and structure)
  //region NEW STYLES
  TextStyle get newSettingsSectionTitle => mBoldStyle;

  TextStyle get newSettingsSectionText => mStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get newSettingsCaption => sBoldStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get newSettingsCaptionSelected => newSettingsCaption.copyWith(
        color: colors.primaryTextInverse,
      );

  TextStyle get newAppButtonText => appButtonText;
//endregion NEW STYLES
}
