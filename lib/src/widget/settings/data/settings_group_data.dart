import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

/// Item, that is displayed in [SettingsGroup]
@immutable
class SettingsGroupData extends Equatable {
  final String? title;
  final List<SettingsTileData> items;

  const SettingsGroupData({
    required this.items,
    this.title,
  }) : assert(
          items.length > 0,
          'There should be at least one tile item',
        );

  @override
  List<Object?> get props => [
        title,
        items,
      ];
}
