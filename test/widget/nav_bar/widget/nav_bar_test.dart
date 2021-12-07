import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/back_button.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/edit.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/icon_button.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

void main() {
  const iconPath = 'packages/xayn_design/assets/icons/arrow_left.svg';
  const keyboardCheckDelay = Duration(milliseconds: 50);
  Widget buildWidget({
    bool aboveTheKeyboard = false,
    EdgeInsets? padding,
  }) {
    NavBarContainer.staticCallsEnabled = false;
    return NavBarContainer(
        child: NavBar(
      keyboardCheckDelay: keyboardCheckDelay,
      aboveTheKeyboard: aboveTheKeyboard,
      padding: padding ?? const EdgeInsets.all(16), //default value
    ));
  }

  final backBtn = NavBarItemBackButton(
    onPressed: () {},
    key: const Key('backBtn'),
  );
  NavBarItemIconButton getIconBtnItem({
    bool isHighlighted = false,
  }) =>
      NavBarItemIconButton(
        svgIconPath: iconPath,
        onPressed: () {},
        isHighlighted: isHighlighted,
        key: Key('icon_btn-key$isHighlighted'),
      );
  NavBarItemEdit getEditItem({
    bool isHighlighted = false,
  }) =>
      NavBarItemEdit(
        svgIconPath: iconPath,
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
        expect(find.byType(HighlightLine), findsNothing);
        expect(find.byType(FutureBuilder), findsNothing);
      },
    );

    testWidgets(
      'GIVEN config with 2 iconBtn and edit items WHEN update config THEN build proper children',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig([
          getIconBtnItem(),
          getEditItem(),
          getEditItem(),
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        expect(find.byType(AppCardWidget), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(3));
        expect(find.byType(SafeArea), findsOneWidget);
        expect(find.byType(HighlightLine), findsNothing);

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
        final config = NavBarConfig([
          getIconBtnItem(isHighlighted: true),
          getEditItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        expect(find.byType(HighlightLine), findsOneWidget);
      },
    );
  });

  group('constructor params', () {
    final futureBuilderType = typeOf<FutureBuilder<double>>();
    testWidgets(
      'GIVEN aboveTheKeyboard is false WHEN update config THEN FutureBuilder is NOT there',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget(aboveTheKeyboard: false));
        final state = getState();
        final config = NavBarConfig([
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        expect(find.byType(futureBuilderType), findsNothing);
      },
    );
    testWidgets(
      'GIVEN aboveTheKeyboard is true WHEN update config THEN FutureBuilder is NOT there',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget(aboveTheKeyboard: true));
        final state = getState();
        final config = NavBarConfig([
          getIconBtnItem(),
        ]);
        state.update(config);

        await tester.pumpAndSettle();

        expect(find.byType(futureBuilderType), findsOneWidget);
        await tester.pump(keyboardCheckDelay);
      },
    );
    testWidgets(
      'GIVEN default padding WHEN create widget THEN EdgeInsets.all(16) applied',
      (final WidgetTester tester) async {
        await tester.pumpLindenApp(buildWidget());
        final state = getState();
        final config = NavBarConfig([
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
        final config = NavBarConfig([
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
          state.update(NavBarConfig([getIconBtnItem(isHighlighted: true)]));
        },
      );

      testWidgets(
        'GIVEN config with one NOT highlighted item WHEN updateConfig method called THEN NO AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final state = getState();
          state.update(NavBarConfig([getIconBtnItem(isHighlighted: false)]));
        },
      );

      testWidgets(
        'GIVEN config with one highlighted and one NOT highlighted items WHEN updateConfig method called THEN NO AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final config = NavBarConfig([
            getIconBtnItem(isHighlighted: true),
            getIconBtnItem(isHighlighted: false),
          ]);
          final state = getState();
          state.update(config);
        },
      );

      testWidgets(
        'GIVEN config with two highlighted items WHEN updateConfig method called THEN AssertionError thrown',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          final config = NavBarConfig([
            getIconBtnItem(isHighlighted: true),
            getIconBtnItem(isHighlighted: true),
          ]);
          final state = getState();
          expect(
            () => state.update(config),
            throwsA(isA<AssertionError>()),
          );
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
