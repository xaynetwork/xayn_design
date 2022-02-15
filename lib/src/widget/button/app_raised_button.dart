import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

enum ButtonColor {
  primary,
  secondary,
  tertiary,
}

const EdgeInsets _defaultPadding = EdgeInsets.all(12);
const EdgeInsets _defaultPaddingIcon = EdgeInsets.zero;
const EdgeInsets _defaultPaddingTextWithIcon =
    EdgeInsets.symmetric(horizontal: 12, vertical: 8);

class AppRaisedButton extends StatefulWidget {
  /// if [onPressed] is null, then button will be `disabled`: opacity apply
  final VoidCallback? onPressed;
  final Widget? _child;
  final String? _text;
  final String? _svgIconPath;
  final ButtonColor color;
  final EdgeInsets contentPadding;
  final bool _circleIcon;

  /// Flag that enable minWidth == minHeight,
  /// This is optional param for all constructors except [AppRaisedButton.icon],
  /// there it is applied by default
  final bool minSizeEqual;

  /// Use this constructor when you need to use button with some custom widget
  const AppRaisedButton({
    Key? key,
    required this.onPressed,
    required Widget child,
    this.color = ButtonColor.primary,
    this.contentPadding = _defaultPadding,
    this.minSizeEqual = false,
  })  : _child = child,
        _text = null,
        _svgIconPath = null,
        _circleIcon = false,
        super(key: key);

  /// Use this constructor when you need create button with text.
  const AppRaisedButton.text({
    Key? key,
    required this.onPressed,
    required String text,
    this.contentPadding = _defaultPadding,
    this.color = ButtonColor.primary,
    this.minSizeEqual = false,
  })  : _text = text,
        _child = null,
        _circleIcon = false,
        _svgIconPath = null,
        super(key: key);

  /// Use this constructor when you need create button with text and icon.
  const AppRaisedButton.textWithIcon({
    Key? key,
    required this.onPressed,
    required String text,
    required String svgIconPath,
    this.contentPadding = _defaultPaddingTextWithIcon,
    this.color = ButtonColor.primary,
    this.minSizeEqual = false,
  })  : _text = text,
        _svgIconPath = svgIconPath,
        _circleIcon = false,
        _child = null,
        super(key: key);

  /// Use this constructor when you need create button with icon.
  const AppRaisedButton.icon({
    Key? key,
    required this.onPressed,
    required String svgIconPath,
    this.contentPadding = _defaultPaddingIcon,
    this.color = ButtonColor.primary,
    bool circle = false,
  })  : _text = null,
        minSizeEqual = true,
        _svgIconPath = svgIconPath,
        _circleIcon = circle,
        _child = null,
        super(key: key);

  @override
  State<AppRaisedButton> createState() => _AppRaisedButtonState();
}

class _AppRaisedButtonState extends State<AppRaisedButton> {
  Linden get linden => UnterDenLinden.getLinden(context);

  OutlinedBorder get shape => widget._circleIcon
      ? const CircleBorder()
      : RoundedRectangleBorder(borderRadius: linden.styles.roundBorder);

  Color get buttonColor => widget.color.fold(
        onPrimary: () => linden.colors.primaryAction,
        onSecondary: () => linden.colors.background,
        onTertiary: () => linden.colors.iconBackground,
      );

  TextStyle get textStyle => widget.color.fold(
        onPrimary: () => linden.styles.buttonTextBright,
        onSecondary: () => linden.styles.appButtonText.copyWith(
          fontSize: 12,
        ),
        onTertiary: () => linden.styles.appButtonText.copyWith(
          fontSize: 12,
        ),
      );

  Size get minSize => Size(
        widget.minSizeEqual
            ? linden.dimen.buttonMinHeight
            : linden.dimen.buttonMinWidth,
        linden.dimen.buttonMinHeight,
      );

  @override
  Widget build(BuildContext context) {
    final btnStyle = ElevatedButton.styleFrom(
      elevation: 0,
      primary: buttonColor,
      shape: shape,
      minimumSize: minSize,
      padding: widget.contentPadding,
    );

    final btn = ElevatedButton(
      style: btnStyle,
      child: DefaultTextStyle(
        style: textStyle,
        child: _buildChild(),
      ),
      onPressed: widget.onPressed,
    );

    return ButtonTheme(
      child: Opacity(
        opacity: widget.onPressed == null ? linden.dimen.disabledOpacity : 1,
        child: btn,
      ),
    );
  }

  Widget _buildChild() {
    if (widget._child != null) {
      return widget._child!;
    }

    final text = _buildText();
    final icon = _buildIcon();
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

  Widget? _buildIcon() => widget._svgIconPath == null
      ? null
      : SvgPicture.asset(
          widget._svgIconPath!,
          width: linden.dimen.iconSize,
          height: linden.dimen.iconSize,
          color: linden.colors.iconInverse,
        );

  Widget? _buildText() => widget._text == null ? null : Text(widget._text!);
}

extension ButtonColorExtension on ButtonColor {
  T fold<T>({
    required T Function() onPrimary,
    required T Function() onSecondary,
    required T Function() onTertiary,
  }) {
    switch (this) {
      case ButtonColor.primary:
        return onPrimary();
      case ButtonColor.secondary:
        return onSecondary();
      case ButtonColor.tertiary:
        return onTertiary();
    }
  }
}
