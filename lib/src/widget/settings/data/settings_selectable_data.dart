import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsSelectableData extends Equatable {
  final Key key;
  final String title;
  final String svgIconPath;
  final bool isSelected;
  final VoidCallback onPressed;

  const SettingsSelectableData({
    required this.key,
    required this.title,
    required this.svgIconPath,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  List<Object?> get props => [
        key,
        title,
        svgIconPath,
        isSelected,
        onPressed,
      ];
}
