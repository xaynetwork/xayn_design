import 'package:flutter/material.dart';
import 'package:xayn_design/src/linden/linden.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.errorText,
    this.textInputAction,
    this.autofocus = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText, errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool autocorrect;
  final bool readOnly;
  final bool enabled;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final textFieldStyle = linden.dimen.isSmallScreen
        ? linden.styles.textInputTextSmall
        : linden.styles.textInputText;

    final textFieldDecoration = decoration(
      linden: linden,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
    );

    final textField = TextField(
      enabled: enabled,
      keyboardAppearance: linden.colors.brightness,
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      autocorrect: autocorrect,
      readOnly: readOnly,
      maxLines: 1,
      style: enabled
          ? textFieldStyle
          : textFieldStyle?.copyWith(
              color: linden.colors.searchInputTextDisabled),
      textInputAction: textInputAction,
      textAlignVertical: TextAlignVertical.center,
      decoration: textFieldDecoration,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
    );

    return textField;
  }

  InputDecoration decoration({
    String? errorText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? hintText,
    TextStyle? hintTextStyle,
    required Linden linden,
  }) {
    final border = OutlineInputBorder(
      borderRadius: linden.styles.roundBorder,
      borderSide: BorderSide(
        width: 0,
        color: linden.colors.transparent,
      ),
    );
    const iconMaxWidth = 48.0;
    const iconMaxHeight = 38.0;
    final horizontalContentPadding =
        linden.dimen.adaptiveUnit(small: 1, normal: 1.5);
    return InputDecoration(
      filled: true,
      fillColor: linden.colors.searchInputFill,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: linden.dimen.adaptiveUnit(small: 1, normal: 1),
      ),
      errorStyle: linden.styles.textInputError,
      hintText: hintText,
      hintStyle: hintTextStyle,
      errorText: errorText,
      errorMaxLines: 2,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      suffixIconConstraints: suffixIcon != null
          ? const BoxConstraints.expand(
              width: iconMaxWidth,
              height: iconMaxHeight,
            )
          : BoxConstraints.tightFor(
              width: horizontalContentPadding,
            ),
      suffixIcon: suffixIcon ?? Container(),
      prefixIconConstraints: prefixIcon != null
          ? BoxConstraints(
              minWidth: linden.dimen.unit1_5,
              minHeight: iconMaxHeight,
              maxWidth: iconMaxWidth,
              maxHeight: iconMaxHeight,
            )
          : BoxConstraints.tightFor(
              width: horizontalContentPadding,
            ),
      prefixIcon: prefixIcon ?? Container(),
    );
  }
}
