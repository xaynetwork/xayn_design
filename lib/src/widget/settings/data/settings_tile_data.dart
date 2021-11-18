import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:xayn_design/xayn_design.dart';

/// Contain all necessary data for each individual [SettingsTile]
@immutable
class SettingsTileData extends Equatable {
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

  @override
  List<Object?> get props => [
        title,
        action,
        svgIconPath,
        subTitle,
      ];
}
