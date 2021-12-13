import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/back_button.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../../constants.dart';

void main() {
  const key = Key('btn_key');
  NavBarItemBackButton getItem([VoidCallback? onPressed]) =>
      NavBarItemBackButton(onPressed: onPressed ?? () {}, key: key);

  NavBarBackButton buildWidget([NavBarItemBackButton? item]) =>
      NavBarBackButton(item ?? getItem());

  testWidgets(
    'GIVEN widget THEN verify children widgets',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget());

      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      // one default in MaterialApp and one in NavBarBackButton
      expect(find.byType(Padding), findsNWidgets(2));
    },
  );
  testWidgets(
    'GIVEN widget THEN verify icon is correct',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget());

      final finder = find.byType(SvgPicture);
      final svgWidget = (finder.first.evaluate().first.widget as SvgPicture);

      expect(
        svgWidget.pictureProvider,
        isA<ExactAssetPicture>(),
      );

      expect(
        (svgWidget.pictureProvider as ExactAssetPicture).assetName,
        equals(assetIconPathArrow),
      );
    },
  );
  testWidgets(
    'GIVEN widget THEN verify proper size',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(buildWidget(), initialLinden: linden);

      final finder = find.byType(SizedBox);
      final sizedBox = (finder.first.evaluate().first.widget as SizedBox);

      expect(
        sizedBox.width,
        equals(linden.dimen.buttonMinHeight),
      );
      expect(
        sizedBox.height,
        equals(linden.dimen.buttonMinHeight),
      );
    },
  );
  testWidgets(
    'GIVEN widget THEN verify proper padding',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(buildWidget(), initialLinden: linden);

      final finder = find.byType(Padding);
      final paddingWidget = (finder.first.evaluate().last.widget as Padding);

      expect(
        paddingWidget.padding,
        equals(EdgeInsets.all(linden.dimen.unit0_5)),
      );
    },
  );
  testWidgets(
    'GIVEN widget THEN verify onPressed called when tap on key',
    (final WidgetTester tester) async {
      var onPressed = false;
      final item = getItem(() {
        onPressed = !onPressed;
      });
      await tester.pumpLindenApp(buildWidget(item));

      expect(onPressed, isFalse);

      await tester.tap(find.byKey(key));
      expect(onPressed, isTrue);

      await tester.tap(find.byKey(key));
      expect(onPressed, isFalse);

      await tester.tap(find.byKey(key));
      expect(onPressed, isTrue);
    },
  );
}
