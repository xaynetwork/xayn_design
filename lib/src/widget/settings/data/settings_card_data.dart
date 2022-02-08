import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

/// Item, that is displayed in [SettingsSection]
@immutable
class SettingsCardData extends Equatable {
  final List<SettingsGroupData> items;

  const SettingsCardData(this.items) : assert(items.length > 0);

  factory SettingsCardData.fromTile(SettingsTileData tile) =>
      SettingsCardData.fromTiles([tile]);

  factory SettingsCardData.fromTiles(Iterable<SettingsTileData> tiles) {
    _buildGroupData(SettingsTileData tileData) =>
        SettingsGroupData(items: [tileData]);

    return SettingsCardData(
      [for (final tile in tiles) _buildGroupData(tile)],
    );
  }

  @override
  List<Object?> get props => [items];
}
