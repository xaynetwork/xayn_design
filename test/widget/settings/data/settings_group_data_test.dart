import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  SettingsGroupData groupData([String? title]) => SettingsGroupData(
        title: 'group $title',
        items: [SettingsTileData(title: 'tile $title')],
      );
  test(
    'GIVEN two groupData objects with same params WHEN compare them THEN return true',
    () {
      expect(groupData() == groupData(), isTrue);
    },
  );

  test(
    'GIVEN groupData model with empty items list THEN throw assertion error',
    () {
      expect(
        () => SettingsGroupData(items: const []),
        throwsA(isA<AssertionError>()),
      );
    },
  );
}
