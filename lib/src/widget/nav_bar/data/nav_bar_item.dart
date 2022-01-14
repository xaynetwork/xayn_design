import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NavBarItem extends Equatable {
  final bool isHighlighted;
  final bool isDisabled;
  final VoidCallback onPressed;
  final Key key;

  const NavBarItem._(
    this.isHighlighted,
    this.isDisabled,
    this.onPressed,
    this.key,
  );
}

class NavBarItemIconButton extends NavBarItem {
  final String svgIconPath;

  const NavBarItemIconButton({
    required this.svgIconPath,
    required bool isHighlighted,
    bool isDisabled = false,
    required VoidCallback onPressed,
    required Key key,
  }) : super._(isHighlighted, isDisabled, onPressed, key);

  @override
  List<Object?> get props => [
        key,
        isHighlighted,
        isDisabled,
        svgIconPath,
      ];
}

class NavBarItemBackButton extends NavBarItem {
  const NavBarItemBackButton({
    required VoidCallback onPressed,
    required Key key,
  }) : super._(false, false, onPressed, key);

  @override
  List<Object?> get props => [
        key,
        isHighlighted,
      ];
}

typedef OnTextChanged = Function(String text);
typedef OnSearchPressed = Function(String text);

class NavBarItemEdit extends NavBarItem {
  final String svgIconPath;
  final String? initialText;
  final String? hint;
  final OnTextChanged? onTextChanged;
  final OnSearchPressed onSearchPressed;
  final bool autofocus;

  NavBarItemEdit({
    required this.svgIconPath,
    required this.onSearchPressed,
    required bool isHighlighted,
    required Key key,
    this.onTextChanged,
    this.initialText,
    this.hint,
    this.autofocus = true,
  }) : super._(isHighlighted, false, () {}, key);

  @override
  List<Object?> get props => [
        key,
        isHighlighted,
        svgIconPath,
        initialText,
        hint,
        autofocus,
      ];
}
