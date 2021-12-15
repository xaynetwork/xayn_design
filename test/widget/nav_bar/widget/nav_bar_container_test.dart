import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_container.dart';
import 'package:xayn_design/xayn_design.dart';
import 'package:xayn_design/xayn_design_test.dart';

import '../../constants.dart';

part 'nav_bar_container_test.utils.dart';

void main() {
  testWidgets(
    'GIVEN NavBatContainer THEN verify widget tree is as expected',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget());

      final containerFinder = find.byType(NavBarContainer);
      final inheritedFinder = find.byType(InheritedNavBarContainer);
      final inheritedNavBarContainer =
          inheritedFinder.evaluate().first.widget as InheritedNavBarContainer;

      expect(containerFinder, findsOneWidget);
      expect(inheritedFinder, findsOneWidget);
      expect(inheritedNavBarContainer, isA<InheritedWidget>());
      expect(getState(), isA<NavBarController>());
    },
  );

  testWidgets(
    'GIVEN widget WHEN nothing happened THEN verify that configPair and currentNavBarConfigMixin are null',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget());

      final state = getState();

      expect(state.configPair, isNull);
      expect(state.currentNavBarConfigMixin, isNull);
    },
  );

  testWidgets(
    'GIVEN widget with config WHEN resetNavBar called THEN grab configs every time',
    (final WidgetTester tester) async {
      const expectedCallCounter = 3;

      final listOfConfigs = <ConfigPair>{};

      for (int i = 0; i < expectedCallCounter; i++) {
        final config = createConfig(numberOfItems: i + 1);
        await tester.pumpLindenApp(buildWidget(
          child: _StatelessConfigWidget(() => config),
        ));

        await tester.resetNavBarWithDebounce();

        await tester.pumpAndSettle();
        listOfConfigs.add(getState().configPair!);
      }

      expect(listOfConfigs.length, equals(expectedCallCounter));
    },
  );

  testWidgets(
    'GIVEN widget with config WHEN update bar called THEN configs will be taken only for the first time',
    (final WidgetTester tester) async {
      final listOfConfigs = <ConfigPair>{};

      for (int i = 0; i < 5; i++) {
        final config = createConfig(numberOfItems: i + 1);
        await tester.pumpLindenApp(buildWidget(
          child: _StatelessConfigWidget(() => config),
        ));
        await tester.pumpAndSettle();

        NavBarContainer.updateNavBar(getContext());

        await tester.pumpAndSettle(updateNabBarDebounceTimeout);
        await tester.pumpAndSettle();
        listOfConfigs.add(getState().configPair!);
      }

      expect(listOfConfigs.length, equals(1));
    },
  );

  testWidgets(
    'GIVEN multiple calls in a row of the updateNavBar WHEN create a widget THEN debounce apply and will be took only last config',
    (final WidgetTester tester) async {
      final listOfConfigs = <ConfigPair?>{};

      const steps = 5;
      late NavBarConfig latestConfig;
      for (int i = 0; i < steps; i++) {
        latestConfig = createConfig(numberOfItems: i + 1);
        await tester.pumpLindenApp(buildWidget(
          child: _StatelessConfigWidget(() => latestConfig),
        ));
        NavBarContainer.updateNavBar(getContext());
        final configPair = getState().configPair;
        if (configPair != null) {
          listOfConfigs.add(configPair);
        }
        expect(listOfConfigs, isEmpty);
      }

      await tester.pumpAndSettle(updateNabBarDebounceTimeout);
      listOfConfigs.add(getState().configPair);
      await tester.pumpAndSettle();

      expect(listOfConfigs.length, equals(1));
      expect(
        listOfConfigs.first!.configMixins.first.navBarConfig,
        latestConfig,
      );
    },
  );

  testWidgets(
    'WHEN resetBar called in state THEN configPair is dropped to null',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget(
        child: _StatelessConfigWidget(() => _backBtnConfig),
      ));
      final state = getState();

      await tester.resetNavBarWithDebounce();

      // verify that it is NOT null after reset and debounce
      expect(state.configPair, isNotNull);

      resetNavBar();
      // verify that it is null after reset before debounce done
      expect(state.configPair, isNull);

      await tester.pumpAndSettle(updateNabBarDebounceTimeout);
    },
  );

  testWidgets(
    'WHEN dispose called THEN nothing happened after reset or update called (streams closed)',
    (final WidgetTester tester) async {
      await tester.pumpLindenApp(buildWidget(
        child: _StatelessConfigWidget(() => _backBtnConfig),
      ));
      final state = getState();

      expect(state.resetStream.isClosed, isFalse);
      expect(state.updateStream.isClosed, isFalse);

      // What we are doing here:
      // we need to remove NavBarContainer from the widgetTree
      // to force NavBarContainerStata.dispose() to be called.
      // And the easiest way to do it - replace it with another widget :)
      await tester.pumpLindenApp(const Center());

      expect(state.resetStream.isClosed, isTrue);
      expect(state.updateStream.isClosed, isTrue);
    },
  );

  group(
    'config changed in the NavBar',
    () {
      testWidgets(
        'WHEN NavBarContainer.updateNavBar called THEN config in NavBar changed',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget(
            child: _StatelessConfigWidget(() => _backBtnConfig),
          ));

          final stateNavBar = getStateNavBar();
          expect(stateNavBar.config, isNull);

          NavBarContainer.updateNavBar(getContext());
          await tester.pumpAndSettle(updateNabBarDebounceTimeout);

          expect(stateNavBar.config, equals(_backBtnConfig));
        },
      );
      testWidgets(
        'WHEN NavBarContainer.resetNavBar called THEN config in NavBar changed',
        (final WidgetTester tester) async {
          var firstTimeCall = true;
          await tester.pumpLindenApp(buildWidget(
            child: _StatelessConfigWidget(
              () => firstTimeCall ? _backBtnConfig : _singleItemConfig,
            ),
          ));

          final stateNavBar = getStateNavBar();
          expect(stateNavBar.config, isNull);

          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, equals(_backBtnConfig));
          firstTimeCall = false;

          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, equals(_singleItemConfig));

          // wait until NavBar update finished
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN configPair without mixin WHEN update nav THEN config in NavBar changed to null',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget(
            child: _StatelessConfigWidget(
              () => _backBtnConfig,
            ),
          ));

          final stateNavBar = getStateNavBar();
          expect(stateNavBar.config, isNull);

          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, equals(_backBtnConfig));
          // we need code above to make sure it is not null

          // now we pushing screen without NavBarConfigMixin
          await tester.pumpLindenApp(buildWidget());

          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, isNull);

          // wait until NavBar update finished
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN configPair with configType.ignored WHEN update nav THEN config in NavBar is still null',
        (final WidgetTester tester) async {
          var firstTimeCall = true;
          await tester.pumpLindenApp(buildWidget(
            child: _StatelessConfigWidget(
              () => firstTimeCall ? _backBtnConfig : _ignoredConfig,
            ),
          ));

          final stateNavBar = getStateNavBar();
          expect(stateNavBar.config, isNull);

          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, equals(_backBtnConfig));
          // we need code above to make sure the config was not null

          // now we will return an ignored config instead of backBtn
          firstTimeCall = false;
          await tester.resetNavBarWithDebounce();
          expect(stateNavBar.config, isNull);
          // we want to verify that ignored `config` was ignored and new config is null

          // wait until NavBar update finished
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN configMixins list with 2 items WHEN _updateBar method called THEN forEach happened in reversed way and latest item in the list will apply',
        // the latest widget in the widget tree with the NavBarConfigMixin will be applied
        (final WidgetTester tester) async {
          final widget = _StatelessConfigWidget(
            () => _singleItemConfig,
            child: _StatelessConfigWidget(() => _backBtnConfig),
          );
          await tester.pumpLindenApp(buildWidget(child: widget));

          final stateNavBar = getStateNavBar();

          expect(stateNavBar.config, isNull);

          await tester.resetNavBarWithDebounce();

          expect(stateNavBar.config, _backBtnConfig);
        },
      );
    },
  );

  group(
    '_getConfigPair method checks',
    () {
      testWidgets(
        'GIVEN widget tree without any widget with NavBarConfigMixin WHEN getConfigPair called THEN return config pair with empty list of mixins',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget());

          await tester.resetNavBarWithDebounce();

          expect(getState().configPair!.configMixins, isEmpty);
        },
      );
      testWidgets(
        'GIVEN widget tree without NavBar widget WHEN getConfigPair method called THEN throw NavBarNotFoundException',
        (final WidgetTester tester) async {
          await tester.pumpLindenApp(buildWidget(withNavBar: false));
          // Still need to add a test, which will catch and test this exception
        },
      );
      testWidgets(
        'GIVEN widget tree with more then 1 NavBar widget WHEN getConfigPair method called THEN throw ToManyNavBarFoundException',
        (final WidgetTester tester) async {
          final widget = buildWidget(child: const NavBar());
          await tester.pumpLindenApp(widget);
          // Still need to add a test, which will catch and test this exception
        },
      );

      testWidgets(
        'GIVEN config pair with two configs WHEN calling reset(goingBack:false) THEN list of mixin will contain 2 configs',
        (final WidgetTester tester) async {
          final widget = _StatelessConfigWidget(
            () => _backBtnConfig,
            child: _StatelessConfigWidget(() => _singleItemConfig),
          );
          await tester.pumpLindenApp(buildWidget(child: widget));
          final state = getState();
          expect(state.configPair, isNull);

          await tester.resetNavBarWithDebounce(goingBack: false);

          expect(
            state.configPair!.configMixins.map((e) => e.navBarConfig).toList(),
            equals([_backBtnConfig, _singleItemConfig]),
          );
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN config pair with tree configs WHEN calling reset(goingBack:true) THEN list of mixin will contain 2 config (last one skipped)',
        (final WidgetTester tester) async {
          final widget = _StatelessConfigWidget(
            () => _singleItemConfig,
            child: _StatelessConfigWidget(
              () => _ignoredConfig,
              child: _StatelessConfigWidget(
                () => _backBtnConfig,
              ),
            ),
          );
          await tester.pumpLindenApp(buildWidget(child: widget));
          final state = getState();
          expect(state.configPair, isNull);

          // first we need to make sure that widget tree is there (simulate Navigator.push)
          await tester.resetNavBarWithDebounce(goingBack: false);

          // and now we can simulate Navigator.pop
          await tester.resetNavBarWithDebounce(goingBack: true);

          expect(
            state.configPair!.configMixins.map((e) => e.navBarConfig).toList(),
            equals([_singleItemConfig, _ignoredConfig]),
          );
          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN widget tree with 3 instances of NavBarConfigMixin WHEN calling reset() THEN currentNavBarConfigMixin is correct one',
        (final WidgetTester tester) async {
          final lastWidget = _StatelessConfigWidget(() => _backBtnConfig);
          final NavBarConfigMixin lastNavBarConfigMixin = lastWidget;

          final widget = _StatelessConfigWidget(
            () => _singleItemConfig,
            child: _StatelessConfigWidget(
              () => _ignoredConfig,
              child: lastWidget,
            ),
          );
          // we need to take the first widget, cos the second one contain `ignored` config,
          // so it will be ignored  :)
          final NavBarConfigMixin preLastNavBarConfigMixin = widget;

          await tester.pumpLindenApp(buildWidget(child: widget));
          final state = getState();

          await tester.resetNavBarWithDebounce(goingBack: false);
          expect(
            state.currentNavBarConfigMixin,
            equals(lastNavBarConfigMixin),
          );

          await tester.resetNavBarWithDebounce(goingBack: true);
          expect(
            state.currentNavBarConfigMixin,
            equals(preLastNavBarConfigMixin),
          );

          await tester.pumpAndSettle();
        },
      );
      testWidgets(
        'GIVEN widget tree with 1 config WHEN going back and and currentNavBarConfigMixin is null THEN last config will NOT be removed from the list',
        (final WidgetTester tester) async {
          final widget = _StatelessConfigWidget(() => _singleItemConfig);
          final NavBarConfigMixin mixin = widget;
          await tester.pumpLindenApp(buildWidget(child: widget));
          final state = getState();

          await tester.resetNavBarWithDebounce(goingBack: true);

          expect(
            state.configPair!.configMixins,
            equals([mixin]),
          );
        },
      );
      testWidgets(
        'GIVEN widget tree with 1 config WHEN going back and and currentNavBarConfigMixin is different THEN last config will NOT be removed from the list',
        (final WidgetTester tester) async {
          final widget = _StatelessConfigWidget(() => _singleItemConfig);
          final NavBarConfigMixin mixin = widget;
          await tester.pumpLindenApp(buildWidget(child: widget));
          final state = getState();
          state.currentNavBarConfigMixin =
              _StatelessConfigWidget(() => _singleItemConfig);

          await tester.resetNavBarWithDebounce(goingBack: true);

          expect(
            state.configPair!.configMixins,
            equals([mixin]),
          );
        },
      );
      testWidgets(
        'GIVEN widget tree with 2 config WHEN going back and and currentNavBarConfigMixin is same THEN last config will be removed from the list',
        (final WidgetTester tester) async {
          final lastWidget = _StatelessConfigWidget(() => _singleItemConfig);
          final NavBarConfigMixin lastMixin = lastWidget;
          final previousWidget =
              _StatelessConfigWidget(() => _backBtnConfig, child: lastWidget);
          final NavBarConfigMixin preLastMixin = previousWidget;

          await tester.pumpLindenApp(buildWidget(child: previousWidget));

          final state = getState();
          state.currentNavBarConfigMixin = lastMixin;

          await tester.resetNavBarWithDebounce(goingBack: true);

          expect(
            state.configPair!.configMixins,
            equals([preLastMixin]),
          );
        },
      );
    },
  );

  group(
    'static methods',
    () {
      Future<BuildContext> buildTreeWithoutNavBarContainer(
        WidgetTester tester,
      ) async {
        await tester.pumpLindenApp(const Center());
        return find.byType(Center).evaluate().first;
      }

      testWidgets(
        'GIVEN widget tree without NavBarContainer WHEN calling reset and update NavBar THEN throw exception',
        (final WidgetTester tester) async {
          final context = await buildTreeWithoutNavBarContainer(tester);

          expect(
            () => resetNavBar(context: context),
            throwsA(isA<NavBarContainerNotFoundException>()),
          );
          expect(
            () => resetNavBar(context: context, goingBack: true),
            throwsA(isA<NavBarContainerNotFoundException>()),
          );
          expect(
            () => updateNavBar(context: context),
            throwsA(isA<NavBarContainerNotFoundException>()),
          );
        },
      );
      testWidgets(
        'GIVEN staticCallsEnabled == false WHEN calling reset and update NavBar THEN nothing happened',
        (final WidgetTester tester) async {
          final context = await buildTreeWithoutNavBarContainer(tester);

          NavBarContainer.staticCallsEnabled = false;

          resetNavBar(context: context);
          resetNavBar(context: context, goingBack: true);
          updateNavBar(context: context);

          NavBarContainer.staticCallsEnabled = true;
        },
      );
    },
  );

  group(
    'reset method check for stateless and stateful',
    () {
      testWidgets(
        'GIVEN stateless WHEN resetNavBar THEN verify config is not null',
        (final WidgetTester tester) async {
          final configWidget = _StatelessConfigWidget(() => _backBtnConfig);
          await tester.pumpLindenApp(buildWidget(child: configWidget));

          final state = getState();
          expect(state.configPair, isNull);

          await tester.resetNavBarWithDebounce();
          expect(state.configPair, isNotNull);
        },
      );

      testWidgets(
        'GIVEN stateful WHEN resetNavBar THEN verify config is not null',
        (final WidgetTester tester) async {
          final configWidget = _StatefulConfigWidget(() => _backBtnConfig);
          await tester.pumpLindenApp(buildWidget(child: configWidget));

          final state = getState();
          expect(state.configPair, isNull);

          await tester.resetNavBarWithDebounce();
          expect(state.configPair, isNotNull);
        },
      );
    },
  );
}
