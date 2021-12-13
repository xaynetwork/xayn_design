import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/settings/data/settings_selectable_data.dart';
import 'package:xayn_design/src/widget/settings/settings.dart';
import 'package:xayn_design/src/widget/settings/widget/settings_selectable.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../constants.dart';

void main() {
  const selectedKey = Key('selected');
  const selectedTitle = 'Selected title';
  const selectedSvgIconPath = assetIconPathArrow;

  const unSelectedKey = Key('unSelected');
  const unSelectedTitle = 'unSelected title';
  const unSelectedSvgIconPath = assetIconPathPlant;

  SettingsSelectableData selected(VoidCallback onPressed) =>
      SettingsSelectableData(
        key: selectedKey,
        title: selectedTitle,
        svgIconPath: selectedSvgIconPath,
        isSelected: true,
        onPressed: onPressed,
      );

  SettingsSelectableData unSelected(VoidCallback onPressed) =>
      SettingsSelectableData(
        key: unSelectedKey,
        title: unSelectedTitle,
        svgIconPath: unSelectedSvgIconPath,
        isSelected: false,
        onPressed: onPressed,
      );

  testWidgets(
    'GIVEN data WHEN creating selectable widget with icons THEN expect to see selectable icons group widget',
    (final WidgetTester tester) async {
      final data = selected(() {});
      final widget = SettingsSelectable.icons(items: [data]);
      await tester.pumpLindenApp(widget);

      expect(find.byType(SettingsSelectableIconGroup), findsOneWidget);
      expect(find.byType(SettingsSelectableGraphicGroup), findsNothing);
      expect(widget.type, equals(SettingsSelectableType.icon));
    },
  );

  testWidgets(
    'GIVEN data WHEN creating selectable widget with graphic THEN expect to see selectable graphic group widget',
    (final WidgetTester tester) async {
      final data = selected(() {});
      final widget = SettingsSelectable.graphics(items: [data]);
      await tester.pumpLindenApp(widget);

      expect(find.byType(SettingsSelectableIconGroup), findsNothing);
      expect(find.byType(SettingsSelectableGraphicGroup), findsOneWidget);
      expect(widget.type, equals(SettingsSelectableType.graphic));
    },
  );

  testWidgets(
    'GIVEN 2 items WHEN create icons THEN verify correct order',
    (final WidgetTester tester) async {
      final items = [
        selected(() {}),
        unSelected(() {}),
      ];
      await tester.pumpLindenApp(SettingsSelectable.icons(items: items));

      final iconFinder = find.byType(SettingsSelectableIcon);

      // verify correct order
      final orderedItems = iconFinder
          .evaluate()
          .map((e) => (e.widget as SettingsSelectableIcon).item)
          .toList();
      expect(orderedItems, items);
    },
  );

  testWidgets(
    'GIVEN 2 items WHEN create graphics THEN verify correct order',
    (final WidgetTester tester) async {
      final items = [
        selected(() {}),
        unSelected(() {}),
      ];
      await tester.pumpLindenApp(SettingsSelectable.graphics(items: items));

      final iconFinder = find.byType(SettingsSelectableGraphic);

      // verify correct order
      final orderedItems = iconFinder
          .evaluate()
          .map((e) => (e.widget as SettingsSelectableGraphic).item)
          .toList();
      expect(orderedItems, items);
    },
  );

  testWidgets(
    'GIVEN items WHEN create icons widget and click on it THEN callback executed',
    (final WidgetTester tester) async {
      var onPressCalled = false;
      final data = selected(() {
        onPressCalled = true;
      });
      final widget = SettingsSelectable.icons(items: [data]);
      await tester.pumpLindenApp(widget);

      expect(onPressCalled, isFalse);
      await tester.tap(find.byKey(selectedKey));
      expect(onPressCalled, isTrue);
    },
  );

  testWidgets(
    'GIVEN items WHEN create graphics widget and click on it THEN callback executed',
    (final WidgetTester tester) async {
      var onPressCalled = false;
      final data = selected(() {
        onPressCalled = !onPressCalled;
      });
      final widget = SettingsSelectable.graphics(items: [data]);
      await tester.pumpLindenApp(widget);

      final keyFinder = find.byKey(selectedKey);
      expect(keyFinder, findsNWidgets(2));

      expect(onPressCalled, isFalse);
      await tester.tap(find.byKey(selectedKey).first);
      expect(onPressCalled, isTrue);
    },
  );
}
