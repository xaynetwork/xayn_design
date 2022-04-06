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

  /// Shadows

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

  TextStyle get searchInfoIncludingTerm => mBoldStyle;

  TextStyle get searchInfoExplicitTerm => mStyle.copyWith(
        color: colors.primaryAction,
      );

  TextStyle get dialogTitleText => lStyle;

  TextStyle get dialogTitleSmall => mStyle;

  TextStyle get dialogErrorBody => mStyle.copyWith(
        fontStyle: FontStyle.italic,
      );

  TextStyle get dialogBody => mStyle;

  TextStyle get dialogBodySmall => sStyle;

  TextStyle get versionText => lStyle.copyWith(
        color: colors.secondaryText,
      );

  TextStyle get snackBarBrightText => lStyle.copyWith(
        color: colors.brightText,
      );

  TextStyle get placeholderText => lStyle.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle get placeholderTextSmall => mStyle.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle get historyButtonText => mStyle;

  /// text styles that are independent of the dark mode

  TextStyle get smallButtonTextBright => sBoldStyle.copyWith(
        color: colors.brightText,
      );

  TextStyle get buttonTextBright => mBoldStyle.copyWith(
        color: colors.brightText,
      );

  TextStyle get appBodyTextBright => mStyle.copyWith(
        color: colors.brightText,
      );

  TextStyle get tooltipText => mBoldStyle.copyWith(
        color: colors.tooltipText,
      );

  TextStyle get tooltipHighlightTextStyle => tooltipText.copyWith(
        color: colors.primaryAction,
      );

  TextStyle get tooltipArrowDownTextStyle => lBoldStyle.copyWith(
        color: colors.brightText,
      );

  TextStyle get subscriptionModalPricingDetailsError => mStyle.copyWith(
        color: colors.inputErrorText,
      );

  TextStyle get readerModeSettingsErrorTextStyle => sBoldStyle.copyWith(
        color: colors.readerModeSettingsErrorTextColor,
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
  final roundBorderCard = BorderRadius.all(Radius.circular(_dimen.cardRadius));

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
    topLeft: Radius.circular(_dimen.cardRadius),
    topRight: Radius.circular(_dimen.cardRadius),
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
}
