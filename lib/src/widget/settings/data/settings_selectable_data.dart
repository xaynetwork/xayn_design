import 'package:flutter/material.dart';

class SettingsSelectableItem {
  final Key key;
  final String title;
  final String svgIconPath;
  final bool isSelected;
  final VoidCallback onPressed;

  SettingsSelectableItem({
    required this.key,
    required this.title,
    required this.svgIconPath,
    required this.isSelected,
    required this.onPressed,
  });
}
