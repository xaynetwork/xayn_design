import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/settings/widget/settings_background.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

void main() {
  const tile0 = SettingsTileData(title: 'tile title 0');
  const tile1 = SettingsTileData(title: 'tile title 1');
  final groupData0 = SettingsGroupData(items: const [tile0, tile1]);
  final groupData1 = SettingsGroupData(items: const [tile1]);
  final groupData2 = SettingsGroupData(items: const [tile0]);
  final linden = Linden(newColors: true);
  testWidgets(
    'GIVEN data with 1 item WHEN render widget THEN find 1 SettingsGroup widget inside',
    (final WidgetTester tester) async {
      final data = SettingsCardData([groupData0]);

      await tester.pumpLindenApp(
        SettingsCard(data: data),
        initialLinden: linden,
      );

      expect(find.byType(SettingsGroup), findsNWidgets(1));
      expect(find.byType(Divider), findsNothing);
      expect(find.byType(SettingsBackground), findsNWidgets(1));
    },
  );
  testWidgets(
    'GIVEN data with 2 items WHEN render widget THEN find 2 SettingsGroup widgets and 1 divider',
    (final WidgetTester tester) async {
      final data = SettingsCardData([groupData0, groupData1]);

      await tester.pumpLindenApp(
        SettingsCard(data: data),
        initialLinden: linden,
      );

      expect(find.byType(SettingsGroup), findsNWidgets(2));
      expect(find.byType(Divider), findsOneWidget);
      expect(find.byType(SettingsBackground), findsNWidgets(1));
    },
  );
  testWidgets(
    'GIVEN data with 3 items WHEN render widget THEN find 3 SettingsGroup widgets and 2 dividers',
    (final WidgetTester tester) async {
      final data = SettingsCardData([groupData0, groupData1, groupData2]);

      await tester.pumpLindenApp(
        SettingsCard(data: data),
        initialLinden: linden,
      );

      final groupFinder = find.byType(SettingsGroup);

      expect(groupFinder, findsNWidgets(3));
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(SettingsBackground), findsNWidgets(1));
    },
  );
  testWidgets(
    'GIVEN data with 3 items WHEN render widget THEN verify correct item order',
    (final WidgetTester tester) async {
      final data = SettingsCardData([groupData2, groupData1, groupData0]);

      await tester.pumpLindenApp(
        SettingsCard(data: data),
        initialLinden: linden,
      );

      final groupFinder = find.byType(SettingsGroup);

      // verify correct order
      final groups = groupFinder
          .evaluate()
          .map((e) => (e.widget as SettingsGroup).data)
          .toList();
      expect(groups, data.items);
    },
  );
}
