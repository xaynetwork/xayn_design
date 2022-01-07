import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../constants.dart';

typedef GetSettingsTileAction = Function(VoidCallback onPressed);

void main() {
  const title = 'SettingsTile title';
  const actionKey = Key('action key');

  group(
    'GIVEN tile with different actions WHEN clicked on the button THEN callback called',
    () {
      Future<void> verifyActionClicked(
        final WidgetTester tester,
        GetSettingsTileAction getAction,
      ) async {
        var onPressCalled = false;
        void onPressed() {
          onPressCalled = true;
        }

        final data = SettingsTileData(
          title: title,
          action: getAction(onPressed),
        );

        await tester.pumpLindenApp(SettingsTile(data: data));

        expect(onPressCalled, isFalse);
        await tester.tap(find.byKey(actionKey));
        expect(onPressCalled, isTrue);
      }

      testWidgets(
          'for text action',
          (final WidgetTester tester) => verifyActionClicked(
                tester,
                // ignore: deprecated_member_use_from_same_package
                (VoidCallback onPressed) => SettingsTileActionText(
                  text: 'hello',
                  onPressed: onPressed,
                  key: actionKey,
                ),
              ));

      testWidgets(
          'for icon action',
          (final WidgetTester tester) => verifyActionClicked(
                tester,
                (VoidCallback onPressed) => SettingsTileActionIcon(
                  svgIconPath: assetIconPathPlant,
                  onPressed: onPressed,
                  key: actionKey,
                ),
              ));

      testWidgets(
        'for circle action, isActive true',
        (WidgetTester tester) => verifyActionClicked(
            tester,
            // ignore: deprecated_member_use_from_same_package
            (VoidCallback onPressed) => SettingsTileActionCircle(
                  isActive: true,
                  svgIconPath: assetIconPathPlant,
                  onPressed: onPressed,
                  key: actionKey,
                )),
      );

      testWidgets(
        'for circle action, isActive false',
        (WidgetTester tester) => verifyActionClicked(
            tester,
            // ignore: deprecated_member_use_from_same_package
            (VoidCallback onPressed) => SettingsTileActionCircle(
                  isActive: false,
                  svgIconPath: assetIconPathPlant,
                  onPressed: onPressed,
                  key: actionKey,
                )),
      );

      testWidgets(
          'for switch action, value true',
          (WidgetTester tester) => verifyActionClicked(
                tester,
                // ignore: deprecated_member_use_from_same_package
                (VoidCallback onPressed) => SettingsTileActionSwitch(
                  value: true,
                  onPressed: onPressed,
                  key: actionKey,
                ),
              ));
      testWidgets(
          'for switch action, value false',
          (WidgetTester tester) => verifyActionClicked(
                tester,
                // ignore: deprecated_member_use_from_same_package
                (VoidCallback onPressed) => SettingsTileActionSwitch(
                  value: false,
                  onPressed: onPressed,
                  key: actionKey,
                ),
              ));
    },
  );

  group(
    'test internal widget visibility with different types of the tile data',
    () {
      testWidgets(
        'GIVEN data with title WHEN rendering widget THEN only title visible',
        (final WidgetTester tester) async {
          const data = SettingsTileData(title: title);
          await tester.pumpLindenApp(const SettingsTile(data: data));

          final titleFinder = find.text(title);

          expect(titleFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(1));
        },
      );
      testWidgets(
        'GIVEN data with title and subtitle WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          const subtitle = 'App subtitle';
          const data = SettingsTileData(title: title, subTitle: subtitle);
          await tester.pumpLindenApp(const SettingsTile(data: data));

          final titleFinder = find.text(title);
          final subTitleFinder = find.text(subtitle);

          expect(titleFinder, findsOneWidget);
          expect(subTitleFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(2));
        },
      );
      testWidgets(
        'GIVEN data with title and icon WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          const data =
              SettingsTileData(title: title, svgIconPath: assetIconPathPlant);
          await tester.pumpLindenApp(const SettingsTile(data: data));

          final titleFinder = find.text(title);
          final iconFinder = find.byType(SvgPicture);

          expect(titleFinder, findsOneWidget);
          expect(iconFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(1));
          expect(find.byType(SvgPicture), findsNWidgets(1));
        },
      );
      testWidgets(
        'GIVEN data with title and action TEXT WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          const btnText = 'btn';
          final data = SettingsTileData(
            title: title,
            // ignore: deprecated_member_use_from_same_package
            action: SettingsTileActionText(
              text: btnText,
              onPressed: () {},
              key: actionKey,
            ),
          );
          await tester.pumpLindenApp(SettingsTile(data: data));

          final titleFinder = find.text(title);
          final btnTextFinder = find.text(btnText);
          final actionFinder = find.byKey(actionKey);

          expect(titleFinder, findsOneWidget);
          expect(actionFinder, findsOneWidget);
          expect(btnTextFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(2));
          expect(find.byType(AppRaisedButton), findsNWidgets(1));
        },
      );
      testWidgets(
        'GIVEN data with title and action ICON WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          final data = SettingsTileData(
            title: title,
            action: SettingsTileActionIcon(
              svgIconPath: assetIconPathPlant,
              onPressed: () {},
              key: actionKey,
            ),
          );
          await tester.pumpLindenApp(SettingsTile(data: data));

          final titleFinder = find.text(title);
          final actionFinder = find.byKey(actionKey);

          expect(titleFinder, findsOneWidget);
          expect(actionFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(1));
          expect(find.byType(SvgPicture), findsNWidgets(1));
          expect(find.byType(AppGhostButton), findsNWidgets(1));
        },
      );
      testWidgets(
        'GIVEN data with title and action CIRCLE WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          final data = SettingsTileData(
            title: title,
            // ignore: deprecated_member_use_from_same_package
            action: SettingsTileActionCircle(
              isActive: true,
              svgIconPath: assetIconPathPlant,
              onPressed: () {},
              key: actionKey,
            ),
          );
          await tester.pumpLindenApp(SettingsTile(data: data));

          final titleFinder = find.text(title);
          final actionFinder = find.byKey(actionKey);

          expect(titleFinder, findsOneWidget);
          expect(actionFinder, findsOneWidget);
          expect(find.byType(Text), findsNWidgets(1));
          expect(find.byType(SvgPicture), findsNWidgets(1));
          expect(find.byType(AppRaisedButton), findsNWidgets(1));
        },
      );
      testWidgets(
        'GIVEN data with title and action SWITCH and value true WHEN rendering widget THEN visible only those are visible',
        (final WidgetTester tester) async {
          final data = SettingsTileData(
            title: title,
            // ignore: deprecated_member_use_from_same_package
            action: SettingsTileActionSwitch(
              value: true,
              onPressed: () {},
              key: actionKey,
            ),
          );
          await tester.pumpLindenApp(SettingsTile(data: data));

          final titleFinder = find.text(title);
          final actionFinder = find.byKey(actionKey);

          expect(titleFinder, findsOneWidget);
          expect(actionFinder, findsOneWidget);
          // 3 texts, cos one is our title and the others
          // are invisible part in FlutterSwitch widget
          expect(find.byType(Text), findsNWidgets(3));
          expect(find.byType(AppSwitchWidget), findsNWidgets(1));
          expect(find.byType(AppRaisedButton), findsNothing);
        },
      );
      testWidgets(
        'GIVEN full data WHEN rendering widget THEN visible all widgets',
        (final WidgetTester tester) async {
          const subtitle = 'subtitle';
          final data = SettingsTileData(
            title: title,
            subTitle: subtitle,
            svgIconPath: assetIconPathPlant,
            action: SettingsTileActionIcon(
              svgIconPath: assetIconPathPlant,
              onPressed: () {},
              key: actionKey,
            ),
          );
          await tester.pumpLindenApp(SettingsTile(data: data));

          final titleFinder = find.text(title);
          final subTitleFinder = find.text(subtitle);
          final actionFinder = find.byKey(actionKey);

          expect(titleFinder, findsOneWidget);
          expect(subTitleFinder, findsOneWidget);
          expect(actionFinder, findsOneWidget);

          expect(find.byType(Text), findsNWidgets(2));
          expect(find.byType(SvgPicture), findsNWidgets(2));
          expect(find.byType(AppGhostButton), findsOneWidget);
        },
      );
    },
  );
}
