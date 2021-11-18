import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/settings/data/settings_selectable_data.dart';

void main() {
  void onPressed() {}
  SettingsSelectableData data([String? key]) => SettingsSelectableData(
        key: Key('key-$key'),
        title: 'title-$key',
        svgIconPath: 'svgIconPath-$key',
        isSelected: true,
        onPressed: onPressed,
      );
  test(
    'GIVEN two instances of the data model with same params WHEN compare them THEN return true',
    () {
      expect(data() == data(), isTrue);
    },
  );
}
