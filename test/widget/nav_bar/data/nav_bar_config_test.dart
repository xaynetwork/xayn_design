import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';

void main() {
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
      final iconBtnItem = NavBarItemIconButton(
        svgIconPath: 'svgIconPath',
        isHighlighted: true,
        onPressed: () {},
        key: const Key('icon btn'),
      );
      final backBtnItem =
          NavBarItemBackButton(onPressed: () {}, key: const Key('back btn'));
      final cardConfig = NavBarConfig(
        [
          iconBtnItem,
          backBtnItem,
        ],
        isWidthExpanded: true,
      );
      final hiddenConfig = NavBarConfig.hidden();
      final ignoredConfig = NavBarConfig.ignored();
      final backConfig = NavBarConfig.backBtn(backBtnItem);

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
              final config = NavBarConfig([iconBtnItem]);
              expect(config.isWidthExpanded, isFalse);
              expect(config.type, NavBarType.card);
              expect(config.items, [iconBtnItem]);
            },
          );
          test(
            'GIVEN config with expanded width THEN verify flag is correct',
            () {
              final config = NavBarConfig([iconBtnItem], isWidthExpanded: true);
              expect(config.isWidthExpanded, isTrue);
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
              expect(backConfig.items, equals([backBtnItem]));
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
            },
          );
        },
      );
    },
  );
}
