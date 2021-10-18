import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/src/xcolors.dart';
import 'package:xayn_design/src/xsizes.dart';

///   We are currently using:
///   FontWeight.w400: 'Regular',
///   FontWeight.w700: 'Bold',
@immutable
class XStyles {
  final TextTheme _baseTextTheme;
  final XColors colors;

  XStyles(
    this._baseTextTheme, {
    Brightness? brightness,
  }) : colors = XColors(brightness);

  FontWeight get _weightBold => FontWeight.w700;

  FontWeight get _weightRegular => FontWeight.w400;

  /// Defined by design

  TextStyle? get appScreenHeadline => _baseTextTheme.headline1?.copyWith(
        color: colors.primaryText,
        fontWeight: _weightBold,
        fontSize: 24.0,
        // height = 32
        height: 1.33,
      );

  TextStyle? get appHeadlineText => _baseTextTheme.headline1?.copyWith(
        color: colors.primaryText,
        fontWeight: _weightBold,
        fontSize: 17.0,
        // height = 24
        height: 1.41,
      );

  TextStyle? get appSmallHeadlineText => _baseTextTheme.headline1?.copyWith(
        color: colors.primaryText,
        fontWeight: _weightBold,
        fontSize: 15,
        height: 1.3,
      );

  TextStyle? get appHighlightText => _baseTextTheme.headline1?.copyWith(
        color: colors.primaryText,
        fontWeight: _weightRegular,
        fontSize: 17.0,
        // height = 24
        height: 1.41,
      );

  TextStyle? get appBodyText => _baseTextTheme.bodyText1?.copyWith(
        color: colors.primaryText,
        fontWeight: _weightRegular,
        fontSize: 13.0,
        // height = 20
        height: 1.54,
      );

  TextStyle? get appButtonText => appBodyText?.copyWith(
        fontWeight: _weightBold,
        fontSize: 13,
        // height = 16
        height: 1.23,
      );

  TextStyle? get appButtonTextOnboarding => appButtonText?.copyWith(
        fontSize: 18.0,
      );

  TextStyle? get appButtonTextOnboardingInverse =>
      appButtonTextOnboarding?.copyWith(
        color: colors.primaryTextInverse,
      );

  TextStyle? get appButtonTextInverse => appButtonText?.copyWith(
        color: colors.primaryTextInverse,
      );

  TextStyle? get appSecondaryButtonText => appBodyText?.copyWith(
        fontWeight: _weightBold,
        color: colors.secondaryActionText,
        height: 1,
      );

  TextStyle? get appThumbnailText => appBodyText?.copyWith(
        fontWeight: _weightBold,
        color: colors.secondaryText,
        fontSize: 10,
        // height = 12
        height: 1.2,
      );

  TextStyle? get settingsLayoutSectionText => appThumbnailText?.copyWith(
        color: colors.primaryText,
        height: 1.3,
      );

  TextStyle? get settingsLayoutSectionTextSelected =>
      settingsLayoutSectionText?.copyWith(
        color: colors.primaryTextInverse,
      );

  TextStyle? get appThumbnailTextDisabled => appBodyText?.copyWith(
        fontWeight: _weightBold,
        height: 1,
        fontSize: 10,
        color: colors.tertiaryText,
      );

  TextStyle? get appThumbnailTextLight => appBodyText?.copyWith(
        fontWeight: _weightRegular,
        fontSize: 10,
        // height = 12
        height: 1.2,
      );

  TextStyle? get linkText => appBodyText?.copyWith(
        color: colors.primaryAction,
        decoration: TextDecoration.underline,
      );

  TextStyle? get textInputText => appBodyText?.copyWith(
        fontSize: 15.0,
        fontWeight: _weightRegular,
        color: colors.searchInputText,
      );

  TextStyle? get textInputTextSmall =>
      textInputText?.copyWith(fontSize: 13.0, height: 1.75);

  TextStyle? get textInputError => appBodyText?.copyWith(
        fontSize: 13.0,
        color: colors.inputErrorText,
      );

  TextStyle? get textInputErrorSmall =>
      textInputError?.copyWith(fontSize: 10.0);

  /// Autosuggestion

  TextStyle? get chipText => appBodyText?.copyWith(
        height: 1.2,
      );

  TextStyle? get chipTextBright => appBodyTextBright?.copyWith(
        height: 1.2,
      );

  TextStyle get marketButtonStyle => TextStyle(
        color: colors.primaryTextInverse,
        fontSize: 14.0,
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

  TextStyle? get searchInfoIncludingTerm => appBodyText?.copyWith(
        fontWeight: _weightBold,
      );

  TextStyle? get searchInfoExplicitTerm => appBodyText?.copyWith(
        color: colors.primaryAction,
      );

  TextStyle? get dialogTitleText => appHighlightText;

  TextStyle? get dialogTitleSmall => dialogTitleText?.copyWith(
        fontSize: 16,
      );

  TextStyle? get dialogErrorBody => appBodyText?.copyWith(
        fontStyle: FontStyle.italic,
        color: colors.primaryText,
      );

  TextStyle? get dialogBody => appBodyText?.copyWith(
        color: colors.primaryText,
      );

  TextStyle? get dialogBodySmall => dialogBody?.copyWith(
        fontSize: 10,
      );

  TextStyle? get versionText => appHighlightText?.copyWith(
        color: colors.secondaryText,
      );

  TextStyle? get cardSubtitleText => appThumbnailText?.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle? get onboardingTitle => appBodyText?.copyWith(
        color: colors.primaryText,
        fontSize: 40,
        fontWeight: _weightBold,
      );

  TextStyle? get snackBarBrightText => appHighlightText?.copyWith(
        color: colors.brightText,
      );

  TextStyle? get placeholderText => appHighlightText?.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle? get placeholderTextSmall => appBodyText?.copyWith(
        color: colors.tertiaryText,
      );

  TextStyle? get historyButtonText => appBodyText?.copyWith(
        color: colors.primaryText,
      );

  /// text styles that are independent of the dark mode

  /// Bright text - used for text within colored boxes like the pixel info in image view
  TextStyle? get infoTextBright => appThumbnailTextLight?.copyWith(
        color: colors.brightText,
      );

  TextStyle? get smallButtonTextBright => appButtonText?.copyWith(
        color: colors.brightText,
        fontSize: 10,
      );

  TextStyle? get buttonTextBright => appButtonText?.copyWith(
        color: colors.brightText,
      );

  TextStyle? get appBodyTextBright => appBodyText?.copyWith(
        color: colors.brightText,
      );

  TextStyle? get webViewBottomMenuTitleText => appBodyText?.copyWith(
        fontWeight: _weightBold,
        height: 1,
      );

  TextStyle? get webViewBottomMenuUrlText => appBodyText?.copyWith(
        height: 1,
      );

  TextStyle? get tooltipText => appBodyText?.copyWith(
        color: colors.tooltipText,
        fontSize: 13,
        fontWeight: _weightBold,
      );

  TextStyle? get betaTagTextStyle => appBodyText?.copyWith(
        fontSize: 8,
        fontWeight: _weightBold,
      );

  /// Other styles

  /// Borders generic
  static XSizes get _dimen => const XSizes.byDefault();
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
