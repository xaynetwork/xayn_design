import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

/// Item, that is displayed in [SettingsSection]
@immutable
class SettingsCardData extends Equatable {
  final List<SettingsGroupData> items;

  const SettingsCardData(this.items);

  factory SettingsCardData.fromTile(SettingsTileData tile) => SettingsCardData([
        SettingsGroupData(items: [tile])
      ]);

  factory SettingsCardData.fromTiles(List<SettingsTileData> tiles) =>
      SettingsCardData(
        tiles.map((tile) => SettingsGroupData(items: [tile])).toList(),
      );

  @override
  List<Object?> get props => [items];
}
