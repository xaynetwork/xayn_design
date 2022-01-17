import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  group(
    'icon button',
    () {
      const iconPath = 'iconPath';
      const isHighlighted = true;
      const isDisabled = false;
      const key = Key('iconBtnKey');
      void onPressed() {}

      final item = NavBarItemIconButton(
        svgIconPath: iconPath,
        isHighlighted: isHighlighted,
        isDisabled: isDisabled,
        onPressed: onPressed,
        key: key,
      );

      test(
        'GIVEN item THEN verify values are equal',
        () {
          expect(item.svgIconPath, iconPath);
          expect(item.onPressed, onPressed);
          expect(item.isHighlighted, isHighlighted);
          expect(item.isDisabled, isDisabled);
          expect(item.key, key);
        },
      );

      test(
        'GIVEN item THEN verify it extends NavBarItem and Equatable ',
        () {
          expect(item, isA<NavBarItem>());
          expect(item, isA<Equatable>());
        },
      );

      test(
        'GIVEN item THEN verify correct props',
        () {
          expect(item.props, [
            key,
            isHighlighted,
            isDisabled,
            iconPath,
          ]);
        },
      );

      test(
        'GIVEN default constructor THEN verify default props',
        () {
          final defaultItem = NavBarItemIconButton(
            svgIconPath: iconPath,
            isHighlighted: isHighlighted,
            onPressed: onPressed,
            key: key,
          );

          expect(defaultItem.isDisabled, isDisabled);
        },
      );

      test(
        'GIVEN isDisabled true THEN verify correct isDisabled value',
        () {
          const isDisabled = true;

          final item = NavBarItemIconButton(
            svgIconPath: iconPath,
            isHighlighted: isHighlighted,
            isDisabled: isDisabled,
            onPressed: onPressed,
            key: key,
          );

          expect(item.isDisabled, isDisabled);
        },
      );
    },
  );
  group(
    'back button',
    () {
      const key = Key('backBtnKey');
      void onPressed() {}

      final item = NavBarItemBackButton(
        onPressed: onPressed,
        key: key,
      );

      test(
        'GIVEN item THEN verify values are equal',
        () {
          expect(item.onPressed, onPressed);
          expect(item.key, key);
        },
      );

      test(
        'GIVEN item THEN verify it extends NavBarItem and Equatable ',
        () {
          expect(item, isA<NavBarItem>());
          expect(item, isA<Equatable>());
        },
      );

      test(
        'GIVEN item THEN verify correct props',
        () {
          expect(item.props, [
            key,
            false,
          ]);
        },
      );
    },
  );
  group(
    'edit',
    () {
      const iconPath = 'iconPath';
      const initialText = 'initial text';
      const hint = 'hint';
      const isHighlighted = true;
      const autofocus = true;
      const key = Key('iconBtnKey');
      void onSearchPressed(String search) {}
      void onTextChanged(String search) {}

      final fullItem = NavBarItemEdit(
        svgIconPath: iconPath,
        isHighlighted: isHighlighted,
        onSearchPressed: onSearchPressed,
        onTextChanged: onTextChanged,
        key: key,
        initialText: initialText,
        hint: hint,
        autofocus: autofocus,
      );

      test(
        'GIVEN item THEN verify values are equal',
        () {
          expect(fullItem.svgIconPath, iconPath);
          expect(fullItem.onSearchPressed, onSearchPressed);
          expect(fullItem.isHighlighted, isHighlighted);
          expect(fullItem.autofocus, autofocus);
          expect(fullItem.initialText, initialText);
          expect(fullItem.hint, hint);
          expect(fullItem.key, key);
        },
      );

      test(
        'GIVEN item THEN verify it extends NavBarItem and Equatable ',
        () {
          expect(fullItem, isA<NavBarItem>());
          expect(fullItem, isA<Equatable>());
        },
      );

      test(
        'GIVEN item THEN verify correct props',
        () {
          expect(fullItem.props, [
            key,
            isHighlighted,
            iconPath,
            initialText,
            hint,
            autofocus,
          ]);
        },
      );

      test(
        'GIVEN minimalistic item THEN verify correct props',
        () {
          final minimalistic = NavBarItemEdit(
            svgIconPath: iconPath,
            isHighlighted: isHighlighted,
            onSearchPressed: onSearchPressed,
            key: key,
          );

          expect(minimalistic.props, [
            key,
            isHighlighted,
            iconPath,
            null,
            null,
            true,
          ]);
        },
      );

      test(
        'GIVEN item THEN verify onSearchPressed and onTextChanged works correctly',
        () {
          late final String pressed;
          late final String changed;
          final minimalistic = NavBarItemEdit(
            svgIconPath: iconPath,
            isHighlighted: isHighlighted,
            onSearchPressed: (String search) {
              pressed = search;
            },
            onTextChanged: (String search) {
              changed = search;
            },
            key: key,
          );

          minimalistic.onSearchPressed('pressed');
          minimalistic.onTextChanged!('changed');

          expect(pressed, equals('pressed'));
          expect(changed, equals('changed'));
        },
      );
    },
  );
}
