import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

void main() {
  const groupTitle = 'group title';
  const tile0 = SettingsTileData(title: 'tile title 0');
  const tile1 = SettingsTileData(title: 'tile title 1');
  const tile2 = SettingsTileData(title: 'tile title 2');

  testWidgets(
    'GIVEN data with 2 items without title WHEN render object THEN find 2 tile widget',
    (final WidgetTester tester) async {
      final data = SettingsGroupData(items: const [tile0, tile1]);

      await tester.pumpLindenApp(SettingsGroup(data: data));

      final titleFinder = find.text(groupTitle);

      expect(titleFinder, findsNothing);
      expect(find.byType(SettingsTile), findsNWidgets(2));
      // 2 tile titles
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(SettingsGroup), findsOneWidget);
    },
  );
  testWidgets(
    'GIVEN data with 2 items with title WHEN render object THEN find 2 tile widget and group title',
    (final WidgetTester tester) async {
      final data = SettingsGroupData(
        items: const [tile0, tile1],
        title: groupTitle,
      );

      await tester.pumpLindenApp(SettingsGroup(data: data));

      final titleFinder = find.text(groupTitle);

      expect(titleFinder, findsOneWidget);
      expect(find.byType(SettingsTile), findsNWidgets(2));
      // 2 tile titles and one group title
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(SettingsGroup), findsOneWidget);
    },
  );
  testWidgets(
    'GIVEN data with 3 items WHEN render object THEN verify correct items order',
    (final WidgetTester tester) async {
      final data = SettingsGroupData(items: const [tile2, tile1, tile0]);

      await tester.pumpLindenApp(SettingsGroup(data: data));

      final tileFinder = find.byType(SettingsTile);

      // verify correct order
      final tiles = tileFinder
          .evaluate()
          .map((e) => (e.widget as SettingsTile).data)
          .toList();
      expect(tiles, data.items);
    },
  );
}
