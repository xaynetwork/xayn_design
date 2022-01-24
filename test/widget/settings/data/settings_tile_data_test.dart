import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/settings/settings.dart';

void main() {
  void onPressed() {}

  SettingsTileData simple([String? title]) =>
      SettingsTileData(title: title ?? 'title');
  SettingsTileData full() => SettingsTileData(
        title: 'title',
        // ignore: deprecated_member_use_from_same_package
        action: SettingsTileActionSwitch(
            value: true, onPressed: onPressed, key: const Key('tile')),
        svgIconPath: 'svgIconPath',
        subTitle: 'subTitle',
      );

  test(
    'GIVEN two tile objects with same params WHEN compare them THEN return true',
    () {
      expect(simple() == simple(), isTrue);
      expect(full() == full(), isTrue);
    },
  );

  test(
    'GIVEN settings tile action icon WHEN tap area called THEN return content',
    () {
      final action = SettingsTileActionIcon(
        key: const Key('tile'),
        onPressed: onPressed,
        svgIconPath: 'svgIconPath',
      );
      expect(action.tapArea, SettingsTileActionTapArea.content);
    },
  );
}
