import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';

void main() {
  NavBarItemIconButton getIconData({
    bool isHighlighted = false,
  }) =>
      NavBarItemIconButton(
        svgIconPath: 'svgIconPath',
        isHighlighted: isHighlighted,
        onPressed: () {},
        key: const Key('icon btn'),
      );
  NavBarItemBackButton getBackData() => NavBarItemBackButton(
        onPressed: () {},
        key: const Key('back btn'),
      );

  group(
    'Check NavBarType',
    () {
      test(
        'GIVEN NavBarType values THEN verify correct names',
        () {
          final expectedNames = [
            'card',
            'backBtn',
            'hidden',
            'ignored',
          ];
          final realNames = NavBarType.values
              .map((e) => e.toString().substring(e.toString().indexOf('.') + 1))
              .toList(growable: false);
          expect(realNames, equals(expectedNames));
        },
      );
    },
  );
  group(
    'Check NavBarConfig',
    () {
      final cardConfig = NavBarConfig(
        [
          getIconData(),
          getIconData(isHighlighted: true),
        ],
        isWidthExpanded: true,
      );
      final hiddenConfig = NavBarConfig.hidden();
      final ignoredConfig = NavBarConfig.ignored();
      final backConfig = NavBarConfig.backBtn(getBackData());

      test(
        'GIVEN NavBarConfig THEN verify it extends Equatable',
        () {
          expect(cardConfig, isA<Equatable>());
          expect(hiddenConfig, isA<Equatable>());
          expect(ignoredConfig, isA<Equatable>());
          expect(backConfig, isA<Equatable>());
        },
      );

      test(
        'GIVEN config THEN props are correct',
        () {
          expect(cardConfig.props, [
            cardConfig.items,
            cardConfig.isWidthExpanded,
            cardConfig.type,
            cardConfig.showAboveKeyboard,
          ]);
        },
      );

      group(
        'main constructor config',
        () {
          test(
            'GIVEN config with main constructor THEN verify type is card',
            () {
              expect(cardConfig.type, NavBarType.card);
            },
          );

          test(
            'GIVEN config THEN verify items are required, the rest is optional',
            () {
              final data = getIconData();
              final config = NavBarConfig([data]);
              expect(config.isWidthExpanded, isFalse);
              expect(config.type, NavBarType.card);
              expect(config.items, [data]);
              expect(config.showAboveKeyboard, isTrue);
            },
          );
          test(
            'GIVEN config with expanded width THEN verify flag is correct',
            () {
              final config =
                  NavBarConfig([getIconData()], isWidthExpanded: true);
              expect(config.isWidthExpanded, isTrue);
            },
          );
          test(
            'GIVEN config with showAboveKeyboard = false width THEN verify flag is correct',
            () {
              final config =
                  NavBarConfig([getIconData()], showAboveKeyboard: false);
              expect(config.showAboveKeyboard, isFalse);
            },
          );
          test(
            'GIVEN config with showAboveKeyboard = true width THEN verify flag is correct',
            () {
              final config =
                  NavBarConfig([getIconData()], showAboveKeyboard: true);
              expect(config.showAboveKeyboard, isTrue);
            },
          );
        },
      );

      group(
        'back btn constructor config',
        () {
          test(
            'GIVEN back config THEN verify items size == 1, type is back and width is false',
            () {
              expect(backConfig.isWidthExpanded, isFalse);
              expect(backConfig.type, equals(NavBarType.backBtn));
              expect(backConfig.items, equals([getBackData()]));
              expect(backConfig.showAboveKeyboard, isFalse);
            },
          );
        },
      );

      group(
        'hidden constructor config',
        () {
          test(
            'GIVEN hidden config THEN verify items size == 0, type is hidden and width is false',
            () {
              expect(hiddenConfig.isWidthExpanded, isFalse);
              expect(hiddenConfig.type, equals(NavBarType.hidden));
              expect(hiddenConfig.items, isEmpty);
              expect(hiddenConfig.showAboveKeyboard, isFalse);
            },
          );
        },
      );

      group(
        'ignored constructor config',
        () {
          test(
            'GIVEN ignored config THEN verify items size == 0, type is ignored and width is false',
            () {
              expect(ignoredConfig.isWidthExpanded, isFalse);
              expect(ignoredConfig.type, NavBarType.ignored);
              expect(ignoredConfig.items, isEmpty);
              expect(ignoredConfig.showAboveKeyboard, isFalse);
            },
          );
        },
      );
    },
  );
  group(
    'asserts',
    () {
      test(
        'GIVEN config with no items WHEN use default constructor THEN throw assert exception',
        () async {
          expect(
            () => NavBarConfig(const []),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      test(
        'GIVEN config with 1 highlighted item WHEN use default constructor THEN will NOT throw assert exception',
        () async {
          expect(
            NavBarConfig([getIconData(isHighlighted: true)]),
            isA<NavBarConfig>(),
          );
        },
      );
      test(
        'GIVEN config with 2 highlighted items WHEN use default constructor THEN will throw assert exception',
        () async {
          expect(
            () => NavBarConfig([
              getIconData(isHighlighted: true),
              getIconData(isHighlighted: true),
            ]),
            throwsA(isA<AssertionError>()),
          );
        },
      );
      test(
        'GIVEN config with backBtn item WHEN use default constructor THEN throw assert exception',
        () async {
          expect(
            () => NavBarConfig(
              [
                getIconData(isHighlighted: true),
                NavBarItemBackButton(onPressed: () {}, key: const Key('key'))
              ],
            ),
            throwsA(isA<AssertionError>()),
          );
        },
      );
    },
  );
}
