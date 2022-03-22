import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const EdgeInsets _defaultContentPadding = EdgeInsets.all(12);
const _defaultBorderRadius = BorderRadius.all(Radius.circular(8));
const EdgeInsets _defaultPaddingIcon = EdgeInsets.zero;
const EdgeInsets _defaultPaddingTextWithIcon = EdgeInsets.symmetric(
  horizontal: 12,
  vertical: 8,
);

class AppGhostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? _child;
  final String? _text;
  final String? _svgIconPath;
  final EdgeInsets contentPadding;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Size? iconSize;
  final bool isWithIconOnly;
  final bool isWithText;

  const AppGhostButton({
    required Widget child,
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultContentPadding,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.textColor,
    Key? key,
  })  : _child = child,
        _text = null,
        _svgIconPath = null,
        isWithIconOnly = false,
        isWithText = false,
        super(key: key);

  const AppGhostButton.text(
    String text, {
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultContentPadding,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    this.textColor,
    Key? key,
  })  : _child = null,
        _text = text,
        _svgIconPath = null,
        iconColor = null,
        iconSize = null,
        isWithIconOnly = false,
        isWithText = true,
        super(key: key);

  const AppGhostButton.icon(
    String svgIconPath, {
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultPaddingIcon,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    Key? key,
  })  : _child = null,
        _text = null,
        _svgIconPath = svgIconPath,
        textColor = null,
        isWithIconOnly = true,
        isWithText = false,
        super(key: key);

  const AppGhostButton.textWithIcon({
    required String text,
    required String svgIconPath,
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultPaddingTextWithIcon,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.textColor,
    Key? key,
  })  : _child = null,
        _text = text,
        _svgIconPath = svgIconPath,
        isWithIconOnly = false,
        isWithText = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final style = TextButton.styleFrom(
      primary: linden.colors.splashColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      padding: contentPadding,
      backgroundColor: backgroundColor,
    );
    return Opacity(
      opacity: onPressed == null ? linden.dimen.disabledOpacity : 1,
      child: _buildTextButton(linden: linden, style: style),
    );
  }

  Widget _buildTextButton({
    required Linden linden,
    required ButtonStyle style,
  }) {
    final textButton = TextButton(
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPressed,
      child: _buildChild(linden),
    );

    /// If the button contains only an icon
    /// set the size to 48x48
    if (isWithIconOnly) {
      return SizedBox(
        height: linden.dimen.iconButtonSize,
        width: linden.dimen.iconButtonSize,
        child: textButton,
      );
    }

    /// If the button contains text
    /// set at least the height to 48
    if (isWithText) {
      return SizedBox(
        height: linden.dimen.iconButtonSize,
        child: textButton,
      );
    }
    return textButton;
  }

  Widget _buildChild(Linden linden) {
    if (_child != null) {
      return _child!;
    }

    final text = _buildText(linden);
    final icon = _buildIcon(linden);
    assert(text != null || icon != null);

    if (text != null && icon == null) {
      return text;
    }
    if (icon != null && text == null) {
      return icon;
    }

    final children = <Widget>[
      icon!,
      SizedBox(width: linden.dimen.unit1_5),
      text!,
    ];
    return Row(
      children: children,
      mainAxisSize: MainAxisSize.min,
    );
  }

  Widget? _buildIcon(Linden linden) => _svgIconPath == null
      ? null
      : SvgPicture.asset(
          _svgIconPath!,
          width: iconSize?.width ?? linden.dimen.iconSize,
          height: iconSize?.height ?? linden.dimen.iconSize,
          color: iconColor ?? linden.colors.icon,
        );

  Widget? _buildText(Linden linden) => _text == null
      ? null
      : Text(
          _text!,
          style: _getTextStyle(linden),
        );

  TextStyle _getTextStyle(Linden linden) => textColor == null
      ? linden.styles.mBoldStyle
      : linden.styles.mBoldStyle.copyWith(
          color: textColor,
        );
}
