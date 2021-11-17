import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

/// Item, that is displayed in [SettingsGroup]
@immutable
class SettingsGroupData {
  final String? title;
  final List<SettingsTileData> items;

  const SettingsGroupData({
    required this.items,
    this.title,
  });
}
