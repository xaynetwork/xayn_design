import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  const tile0 = SettingsTileData(title: 'SettingsTileData');
  const tile1 = SettingsTileData(
    title: 'SettingsTileData1',
    subTitle: 'Subtitle',
  );

  test(
    'GIVEN model with empty items list THEN throw assertion error',
    () {
      expect(
        () => SettingsCardData(const []),
        throwsA(isA<AssertionError>()),
      );
    },
  );

  test(
    'GIVEN list with group data models WHEN create class via main constructor THEN same items presented inside class',
    () {
      // ARRANGE
      final groupItem0 = SettingsGroupData(
        title: 'SettingsGroupData',
        items: const [tile0],
      );
      final groupItem1 = SettingsGroupData(
        title: 'SettingsGroupData1',
        items: const [tile0, tile1],
      );
      final expected = [groupItem0, groupItem1];

      // ACT
      final cardData = SettingsCardData(expected);

      // ASSERT
      expect(cardData.items, equals(expected));
    },
  );

  test(
    'GIVEN tile item WHEN creating class with single tile THEN items size is 1 and contains same tile',
    () {
      // ARRANGE
      final expected = [
        SettingsGroupData(items: const [tile0])
      ];

      // ACT
      final cardData = SettingsCardData.fromTile(tile0);

      // ASSERT
      expect(cardData.items, equals(expected));
    },
  );

  test(
    'GIVEN list of tiles WHEN create cardData model THEN model contains same items',
    () {
      // ARRANGE
      final expected = [
        SettingsGroupData(items: const [tile0]),
        SettingsGroupData(items: const [tile1]),
      ];

      // ACT
      final cardData = SettingsCardData.fromTiles(const [tile0, tile1]);

      // ASSERT
      expect(cardData.items, equals(expected));
    },
  );
}
