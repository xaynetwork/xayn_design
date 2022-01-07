import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/icon_button.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../../constants.dart';

void main() {
  const key = Key('icon_button');
  NavBarItemIconButton getItem({
    VoidCallback? onPressed,
  }) =>
      NavBarItemIconButton(
        svgIconPath: assetIconPathArrow,
        isHighlighted: false,
        onPressed: onPressed ?? () {},
        key: key,
      );

  Widget buildWidget([NavBarItemIconButton? item]) =>
      NavBarIconButton(item ?? getItem());

  testWidgets(
    'GIVEN widget THEN verify children widgets',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget(), withScaffold: true);

      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      // one in Material and 2 ours
      expect(find.byType(SizedBox), findsNWidgets(3));
      expect(find.byType(Center), findsNWidgets(2));
    },
  );
  testWidgets(
    'GIVEN widget THEN verify svg icon and size',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(
        buildWidget(),
        initialLinden: linden,
        withScaffold: true,
      );

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

      expect(svgWidget.width, equals(linden.dimen.iconSize));
      expect(svgWidget.height, equals(linden.dimen.iconSize));
    },
  );
  testWidgets(
    'GIVEN widget THEN verify proper sizes',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(
        buildWidget(),
        initialLinden: linden,
        withScaffold: true,
      );

      final finder = find.byType(SizedBox);

      final lasBox = (finder.first.evaluate().last.widget as SizedBox);
      expect(lasBox.width, equals(linden.dimen.navBarItemHeight));
      expect(lasBox.height, equals(linden.dimen.navBarItemHeight));

      final preLasBox = (finder.evaluate().toList()[1].widget as SizedBox);
      expect(preLasBox.width, equals(linden.dimen.navBarSelectableHeight));
      expect(preLasBox.height, equals(linden.dimen.navBarSelectableHeight));
    },
  );

  testWidgets(
    'GIVEN widget THEN verify onPressed called when tap on key',
    (final WidgetTester tester) async {
      var onPressed = false;
      final item = getItem(onPressed: () {
        onPressed = !onPressed;
      });
      await tester.pumpLindenApp(buildWidget(item), withScaffold: true);

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
