import 'package:flutter/material.dart';

class SettingsSelectableData {
  final Key key;
  final String title;
  final String svgIconPath;
  final bool isSelected;
  final VoidCallback onPressed;

  SettingsSelectableData({
    required this.key,
    required this.title,
    required this.svgIconPath,
    required this.isSelected,
    required this.onPressed,
  });
}
