import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const EdgeInsets _defaultContentPadding = EdgeInsets.all(12);
const _defaultBorderRadius = BorderRadius.all(Radius.circular(8));
const EdgeInsets _defaultPaddingIcon = EdgeInsets.zero;
const EdgeInsets _defaultPaddingTextWithIcon =
    EdgeInsets.symmetric(horizontal: 12, vertical: 8);

class AppGhostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? _child;
  final String? _text;
  final String? _svgIconPath;
  final EdgeInsets contentPadding;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;

  const AppGhostButton({
    required Widget child,
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultContentPadding,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    Key? key,
  })  : _child = child,
        _text = null,
        _svgIconPath = null,
        super(key: key);

  const AppGhostButton.text(
    String text, {
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultContentPadding,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    Key? key,
  })  : _child = null,
        _text = text,
        _svgIconPath = null,
        super(key: key);

  const AppGhostButton.icon(
    String svgIconPath, {
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultPaddingIcon,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    Key? key,
  })  : _child = null,
        _text = null,
        _svgIconPath = svgIconPath,
        super(key: key);

  const AppGhostButton.textWithIcon({
    required String text,
    required String svgIconPath,
    required this.onPressed,
    this.onLongPressed,
    this.contentPadding = _defaultPaddingTextWithIcon,
    this.borderRadius = _defaultBorderRadius,
    this.backgroundColor,
    Key? key,
  })  : _child = null,
        _text = text,
        _svgIconPath = svgIconPath,
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
      child: TextButton(
        style: style,
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: _buildChild(linden),
      ),
    );
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
          width: linden.dimen.iconSize,
          height: linden.dimen.iconSize,
          color: linden.colors.icon,
        );

  Widget? _buildText(Linden linden) => _text == null
      ? null
      : Text(
          _text!,
          style: linden.styles.newAppButtonText,
        );
}
