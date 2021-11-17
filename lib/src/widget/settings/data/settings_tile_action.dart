import 'package:flutter/material.dart';

@immutable
abstract class SettingsTileAction {
  final Key key;
  final VoidCallback onPressed;

  const SettingsTileAction(this.key, this.onPressed);
}

@immutable
class SettingsTileActionText extends SettingsTileAction {
  final String text;

  const SettingsTileActionText({
    required this.text,
    required VoidCallback onPressed,
    required Key key,
  }) : super(key, onPressed);
}

class SettingsTileActionIcon extends SettingsTileAction {
  final String svgIconPath;

  const SettingsTileActionIcon({
    required this.svgIconPath,
    required VoidCallback onPressed,
    required Key key,
  }) : super(key, onPressed);
}

class SettingsTileActionCircle extends SettingsTileAction {
  final String svgIconPath;
  final bool isActive;

  const SettingsTileActionCircle({
    required this.svgIconPath,
    required this.isActive,
    required VoidCallback onPressed,
    required Key key,
  }) : super(key, onPressed);
}

class SettingsTileActionSwitch extends SettingsTileAction {
  final bool value;

  const SettingsTileActionSwitch({
    required this.value,
    required VoidCallback onPressed,
    required Key key,
  }) : super(key, onPressed);
}
