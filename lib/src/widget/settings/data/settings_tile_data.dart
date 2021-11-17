import 'package:flutter/foundation.dart';
import 'package:xayn_design/xayn_design.dart';

/// Contain all necessary data for each individual [SettingsTileWidget]
@immutable
class SettingsTileData {
  final String title;
  final SettingsTileAction? action;
  final String? svgIconPath;
  final String? subTitle;

  const SettingsTileData({
    required this.title,
    this.action,
    this.svgIconPath,
    this.subTitle,
  });
}
