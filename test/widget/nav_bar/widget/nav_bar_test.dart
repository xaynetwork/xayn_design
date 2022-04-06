import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/back_button.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/edit.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/icon_button.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../constants.dart';

void main() {
  Widget buildWidget({
    EdgeInsets? padding,
  }) {
    // This is the main place, where this flag is really needed.try
    // The main purpose of it is to have possibility to test NavBar outside of
    // the NavBarContainer and it influence, separately, in its own sandpit.
    NavBarContainer.staticCallsEnabled = false;
    return NavBar(
      padding: padding ?? const EdgeInsets.all(16), //default value
    );
  }

  const defaultId = NavBarConfigId('default');
  final backBtn = NavBarItemBackButton(
    onPressed: () {},
    key: const Key('backBtn'),
  );
  NavBarItemIconButton getIconBtnItem({
    bool isHighlighted = false,
  }) =>
      NavBarItemIconButton(
        svgIconPath: assetIconPathArrow,
        onPressed: () {},
        isHighlighted: isHighlighted,
        key: Key('icon_btn-key$isHighlighted'),
      );
  NavBarItemEdit getEditItem({
    bool isHighlighted = false,
  }) =>
      NavBarItemEdit(
        svgIconPath: assetIconPathArrow,
        onSearchPressed: (_) {},
        isHighlighted: isHighlighted,
        key: Key('edit-key$isHighlighted'),
      );

  NavBarState getState() =>
      (find.byType(NavBar).first.evaluate().first as StatefulElement).state
          as NavBarState;

  Padding getMainPadding() =>
      find.byType(Padding).evaluate().toList()[1].widget as Padding;

  group('different configs', () {
    testWidgets(
      'GIVEN config with isWidthExpanded=false WHEN updating config in widget THEN row size=min and mainAxisAlignment=start',
      (final WidgetTester tester) async {
        final config = NavBarConfig(
          defaultId,
          [getEditItem()],
          isWidthExpanded: false,
        );
        await tester.pumpLindenApp(buildWidget());
        getState().update(config);
        await tester.pumpAndSettle();

        final widget = find.byType(Row).evaluate().first.widget as Row;

        expect(widget.mainAxisSize, equals(MainAxisSize.min));
        expect(widget.mainAxisAlignment, equals(MainAxisAlignment.start));
      },
    );
    testWidgets(
      'GIVEN config with isWidthExpanded=true WHEN updating config in widget THEN row size=max and mainAxisAlignment=spaceBetween',
      (final WidgetTester tester) async {
        final config = NavBarConfig(
          defaultId,
          [getEditItem()],
          isWidthExpanded: true,
        );
        await tester.pumpLindenApp(buildWidget());
        getState().update(config);
        await tester.pumpAndSettle();

        final widget = find.byType(Row).evaluate().first.widget as Row;

        expect(
          widget.mainAxisSize,
          equals(MainAxisSize.max),
        );
        expect(
          widget.mainAxisAlignment,
          equals(MainAxisAlignment.spaceBetween),
        );
      },
    );

    testWidgets(
      'WHEN create a widget THEN state implements ConfigUpdater, default config is null and build Center',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());

        final state = getState();
        expect(state, isA<ConfigUpdater>());
        expect(state.config, isNull);
        expect(find.byType(Center), findsOneWidget);
        expect(find.byType(Row), findsNothing);
        expect(find.byType(AppCardWidget), findsNothing);
      },
    );
    testWidgets(
      'GIVEN null or hidden config WHEN create a widget THEN Center widget build',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());

        final state = getState();

        state.update(NavBarConfig.hidden());
        await tester.pumpAndSettle();

        expect(state.config, equals(NavBarConfig.hidden()));
        expect(find.byType(Center), findsOneWidget);
        expect(find.byType(Row), findsNothing);
      },
    );
    testWidgets(
      'GIVEN config with backBtn WHEN create a widget THEN correct children build',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());

        final state = getState();
        state.update(NavBarConfig.backBtn(backBtn));

        await tester.pumpAndSettle();

        expect(find.byType(SafeArea), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(NavBarBackButton), findsOneWidget);
        expect(find.byType(AppCardWidget), findsNothing);
        expect(find.byType(FutureBuilder), findsNothing);
      },
    );

    testWidgets(
      'GIVEN config with 2 iconBtn and edit items WHEN update config THEN build proper children',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig(defaultId, [
          getIconBtnItem(),
          getEditItem(),
          getEditItem(),
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        expect(find.byType(Row), findsNWidgets(3));
        expect(find.byType(SafeArea), findsOneWidget);

        final rowWithItems = find.byType(Row).evaluate().first.widget as Row;
        expect(find.byType(NavBarIconButton), findsNWidgets(2));
        expect(find.byType(NavBarEdit), findsNWidgets(2));
        // 2 NavBarEdit and 2 EditText inside of it
        expect(find.byType(Expanded), findsNWidgets(4));
        expect(rowWithItems.children.length, equals(config.items.length));
      },
    );

    testWidgets(
      'GIVEN config highlighted item WHEN update config THEN HighlightLine is there',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig(defaultId, [
          getIconBtnItem(isHighlighted: true),
          getEditItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();
      },
    );
  });

  group('constructor params', () {
    testWidgets(
      'GIVEN aboveTheKeyboard is false WHEN update config THEN default padding applied',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig(
          defaultId,
          [getIconBtnItem()],
          showAboveKeyboard: false,
        );
        state.update(config);

        await tester.pumpAndSettle();

        final padding = getMainPadding();
        expect(padding.padding, equals(const EdgeInsets.all(16)));
      },
    );
    testWidgets(
      'GIVEN config with showAboveKeyboard = true WHEN update config THEN extra bottom padding added from the MediaQuery',
      (final WidgetTester tester) async {
        const keyboardHeight = 42.0;
        const data = MediaQueryData(
          size: Size(600, 800),
          viewInsets: EdgeInsets.all(keyboardHeight),
        );
        final mediaQuery = MediaQuery(data: data, child: buildWidget());
        await tester.pumpLindenApp(mediaQuery);
        final state = getState();
        final config = NavBarConfig(
          defaultId,
          [getIconBtnItem()],
          showAboveKeyboard: true,
        );
        state.update(config);

        await tester.pumpAndSettle();

        final padding = getMainPadding();
        expect(
          padding.padding,
          equals(const EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardHeight)),
        );
      },
    );
    testWidgets(
      'GIVEN default padding WHEN create widget THEN EdgeInsets.all(16) applied',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig(defaultId, [
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        final padding = getMainPadding();
        expect(padding.padding, equals(const EdgeInsets.all(16)));
      },
    );
    testWidgets(
      'GIVEN custom padding WHEN create widget THEN it is applied',
      (final WidgetTester tester) async {
        const customPadding = EdgeInsets.fromLTRB(1, 2, 3, 4);
        await tester.pumpLindenApp(buildWidget(padding: customPadding));
        final state = getState();
        final config = NavBarConfig(defaultId, [
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        final padding = getMainPadding();
        expect(padding.padding, equals(customPadding));
      },
    );
  });

  group(
    'update config method',
    () {
      testWidgets(
        'GIVEN ignored config WHEN updateConfig method called THEN throw AssertionError',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final state = getState();

          expect(
            () => state.update(NavBarConfig.ignored()),
            throwsA(isA<AssertionError>()),
          );
        },
      );

      testWidgets(
        'GIVEN config with one highlighted item WHEN updateConfig method called THEN NO AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final state = getState();
          state.update(NavBarConfig(
            defaultId,
            [getIconBtnItem(isHighlighted: true)],
          ));
        },
      );

      testWidgets(
        'GIVEN config with one NOT highlighted item WHEN updateConfig method called THEN NO AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final state = getState();
          state.update(NavBarConfig(
            defaultId,
            [getIconBtnItem(isHighlighted: false)],
          ));
        },
      );

      testWidgets(
        'GIVEN config with one highlighted and one NOT highlighted items WHEN updateConfig method called THEN NO AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final config = NavBarConfig(defaultId, [
            getIconBtnItem(isHighlighted: true),
            getIconBtnItem(isHighlighted: false),
          ]);
          final state = getState();
          state.update(config);
        },
      );

      testWidgets(
        'GIVEN non nullable config and then nullable WHEN updateConfig method called THEN verify config is null',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());
          final state = getState();

          state.update(NavBarConfig.backBtn(backBtn));
          expect(state.config, isNotNull);
          state.update(null);
          expect(state.config, isNull);
        },
      );
    },
  );
}
