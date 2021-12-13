import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../constants.dart';

void main() {
  const title = 'Section title';
  const subTitle = 'Section subTitle';
  const tileTitle = 'tileTitle';
  const tile = SettingsTileData(title: tileTitle);
  testWidgets(
    'WHEN create section from tile and title THEN expect to see title and one card with tile',
    (final WidgetTester tester) async {
      final widget = SettingsSection.fromTile(title: title, tileData: tile);

      await tester.pumpLindenApp(widget);

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.text(title), findsOneWidget);
      expect(find.text(tileTitle), findsOneWidget);
      expect(find.byType(AppCardWidget), findsOneWidget);
      expect(find.byType(SettingsGroup), findsOneWidget);
      expect(find.byType(SettingsTile), findsOneWidget);
    },
  );

  testWidgets(
    'GIVEN subtitle and 3 card data WHEN create section THEN expect to see 3 cards and subtitle',
    (final WidgetTester tester) async {
      final widget = SettingsSection(
        title: title,
        subTitle: subTitle,
        items: [
          SettingsCardData.fromTile(tile),
          SettingsCardData.fromTile(tile),
          SettingsCardData.fromTile(tile),
        ],
      );

      await tester.pumpLindenApp(widget);

      // 3 tiles + title + subtitle
      expect(find.byType(Text), findsNWidgets(5));
      expect(find.text(title), findsOneWidget);
      expect(find.text(subTitle), findsOneWidget);
      expect(find.text(tileTitle), findsNWidgets(3));
      expect(find.byType(AppCardWidget), findsNWidgets(3));
      expect(find.byType(SettingsGroup), findsNWidgets(3));
      expect(find.byType(SettingsTile), findsNWidgets(3));
    },
  );

  testWidgets(
    'GIVEN subtitle and custom widget WHEN create section THEN expect to find subtitle and custom widget inside',
    (final WidgetTester tester) async {
      const subTitle = 'Section subTitle';
      final selectableItem = SettingsSelectableData(
        key: const Key('key'),
        title: 'title',
        svgIconPath: assetIconPathArrow,
        isSelected: true,
        onPressed: () {},
      );
      final widget = SettingsSection.custom(
        title: title,
        subTitle: subTitle,
        child: SettingsSelectable.icons(items: [selectableItem]),
      );

      await tester.pumpLindenApp(widget);

      expect(find.text(title), findsOneWidget);
      expect(find.text(subTitle), findsOneWidget);
      expect(find.byType(SettingsSelectable), findsOneWidget);
      expect(widget.items.length, equals(0));
    },
  );

  testWidgets(
    'GIVEN topTitle < 0 WHEN create section THEN throw assert exception',
    (final WidgetTester tester) async {
      const topPadding = -1.0;
      Widget build() => SettingsSection(
            title: title,
            items: [SettingsCardData.fromTile(tile)],
            topPadding: topPadding,
          );
      Widget build0() => SettingsSection.fromTile(
            title: title,
            tileData: tile,
            topPadding: topPadding,
          );
      Widget build1() => SettingsSection.custom(
            title: title,
            topPadding: topPadding,
            child: const SizedBox(height: 100),
          );

      expect(
        build,
        throwsA(isA<AssertionError>()),
      );
      expect(
        build0,
        throwsA(isA<AssertionError>()),
      );
      expect(
        build1,
        throwsA(isA<AssertionError>()),
      );
    },
  );
}
