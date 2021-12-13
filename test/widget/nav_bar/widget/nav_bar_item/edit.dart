import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/edit.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../../constants.dart';

void main() {
  const key = Key('edit_text');
  NavBarItemEdit getItem({
    Function(String)? onSearchPressed,
    Function(String)? onTextChanged,
    String? initialText,
    String? hint,
    bool? autofocus,
  }) =>
      NavBarItemEdit(
        svgIconPath: assetIconPathArrow,
        isHighlighted: false,
        onSearchPressed: onSearchPressed ?? (_) {},
        onTextChanged: onTextChanged,
        key: key,
        hint: hint,
        initialText: initialText,
        autofocus: autofocus ?? true, // default value
      );

  // we need Scaffold here, cos inside NavBarIconButton we use TextField,
  // which will not work without Material widget
  Widget buildWidget({
    NavBarItemEdit? item,
    FocusNode? focusNode,
    Function(BuildContext context)? updater,
  }) =>
      Scaffold(
          body: NavBarEdit(
        item ?? getItem(),
        focusNode: focusNode,
        updater: updater ?? (_) {},
      ));

  testWidgets(
    'GIVEN widget THEN verify children widgets',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget());

      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    },
  );

  testWidgets(
    'GIVEN widget THEN verify icon is correct',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(buildWidget(), initialLinden: linden);

      final finder = find.byType(SvgPicture);
      final svgWidget = (finder.first.evaluate().first.widget as SvgPicture);

      expect(
        svgWidget.pictureProvider,
        isA<ExactAssetPicture>(),
      );
      expect(svgWidget.width, equals(linden.dimen.iconSize));
      expect(svgWidget.height, equals(linden.dimen.iconSize));

      expect(
        (svgWidget.pictureProvider as ExactAssetPicture).assetName,
        equals(assetIconPathArrow),
      );

      final inkWidget =
          (find.byType(InkWell).first.evaluate().first.widget as InkWell);
      expect(inkWidget.child, isA<Center>());
      expect((inkWidget.child as Center).child, equals(svgWidget));
    },
  );

  testWidgets(
    'GIVEN widget THEN verify main container',
    (final WidgetTester tester) async {
      final linden = Linden();
      await tester.pumpLindenApp(buildWidget(), initialLinden: linden);

      final finder = find.byType(Container).last;
      final container = (finder.evaluate().first.widget as Container);

      expect(
        container.constraints?.maxHeight,
        equals(linden.dimen.navBarSelectableHeight),
      );
      expect(
        (container.decoration as BoxDecoration).color,
        equals(linden.colors.searchInputFill),
      );
    },
  );

  testWidgets(
    'GIVEN widget WHEN click on the item THEN requestFocus called',
    (final WidgetTester tester) async {
      final focusNode = FocusNode();
      var requestFocusCounter = 0;
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          requestFocusCounter++;
          focusNode.unfocus();
        }
      });
      await tester.pumpLindenApp(buildWidget(focusNode: focusNode));

      final finder = find.byType(InkWell);
      const clicksCount = 3;
      for (int i = 0; i < clicksCount; i++) {
        await tester.tap(finder);
      }
      // + one for the request inside initState()
      expect(requestFocusCounter, equals(clicksCount + 1));
    },
  );

  testWidgets(
    'GIVEN widget WHEN click the widget with the key THEN requestFocus called',
    (final WidgetTester tester) async {
      final focusNode = FocusNode();
      var requestFocusCounter = 0;
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          requestFocusCounter++;
          focusNode.unfocus();
        }
      });
      await tester.pumpLindenApp(buildWidget(focusNode: focusNode));

      final finder = find.byKey(key);
      const clicksCount = 3;
      for (int i = 0; i < clicksCount; i++) {
        await tester.tap(finder);
      }
      // + one for the request inside initState()
      expect(requestFocusCounter, equals(clicksCount + 1));
    },
  );

  testWidgets(
    'GIVEN widget THEN verify TextField is correct',
    (final WidgetTester tester) async {
      final linden = Linden();
      final focusNode = FocusNode();
      const hint = 'hint';
      void onTextChanged(String text) {}
      void onSearchPressed(String text) {}
      final item = getItem(
        onSearchPressed: onSearchPressed,
        onTextChanged: onTextChanged,
        hint: hint,
      );
      await tester.pumpLindenApp(buildWidget(item: item, focusNode: focusNode),
          initialLinden: linden);

      final finder = find.byType(TextField);
      final textField = (finder.evaluate().first.widget as TextField);

      expect(textField.key, equals(key));
      expect(textField.focusNode, equals(focusNode));
      expect(textField.style, equals(linden.styles.textInputTextSmall));
      expect(textField.textInputAction, equals(TextInputAction.search));
      expect(textField.maxLines, equals(1));
      expect(textField.onSubmitted, equals(onSearchPressed));
      expect(textField.onChanged, equals(onTextChanged));
      expect(textField.decoration?.hintText, equals(hint));
      expect(textField.decoration?.hintStyle,
          equals(linden.styles.textInputHintSmall));
    },
  );

  testWidgets(
    'GIVEN initial text WHEN create widget THEN text is equal to initial text',
    (final WidgetTester tester) async {
      final item = getItem(initialText: 'initial');
      await tester.pumpLindenApp(buildWidget(item: item));

      final finder = find.byType(TextField);
      final textField = (finder.evaluate().first.widget as TextField);

      final controller = textField.controller!;
      expect(controller.text, equals(item.initialText));
    },
  );

  testWidgets(
    'GIVEN autofocus false WHEN create widget THEN request focus NOT called',
    (final WidgetTester tester) async {
      final focusNode = FocusNode();
      var requestFocusCounter = 0;
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          requestFocusCounter++;
          focusNode.unfocus();
        }
      });
      final item = getItem(autofocus: false);
      await tester.pumpLindenApp(buildWidget(item: item, focusNode: focusNode));

      // need await cos of code in initState
      // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      await tester.pumpAndSettle();

      expect(requestFocusCounter, equals(0));
    },
  );

  testWidgets(
    'GIVEN default item WHEN create widget THEN request focus called (default behaviour)',
    (final WidgetTester tester) async {
      final focusNode = FocusNode();
      var requestFocusCounter = 0;
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          requestFocusCounter++;
          focusNode.unfocus();
        }
      });
      final item = NavBarItemEdit(
        svgIconPath: assetIconPathArrow,
        isHighlighted: false,
        onSearchPressed: (_) {},
        key: key,
      );
      await tester.pumpLindenApp(buildWidget(item: item, focusNode: focusNode));

      // need await cos of code in initState
      // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      await tester.pumpAndSettle();

      expect(requestFocusCounter, equals(1));
    },
  );

  testWidgets(
    'GIVEN widget WHEN request focus listener triggered THEN call update navBar',
    (final WidgetTester tester) async {
      final focusNode = FocusNode();
      var updateNavBarCounter = 0;
      void updateNavBar(BuildContext context) {
        updateNavBarCounter++;
      }

      final widget = buildWidget(focusNode: focusNode, updater: updateNavBar);
      await tester.pumpLindenApp(widget);

      focusNode.unfocus(); //+1
      await tester.pumpAndSettle();
      focusNode.requestFocus(); //+1
      await tester.pumpAndSettle();
      focusNode.unfocus(); //+1
      await tester.pumpAndSettle();

      // + one for the request inside initState()
      expect(updateNavBarCounter, equals(4));
    },
  );
}
