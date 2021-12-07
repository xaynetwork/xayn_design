import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/utils/design_testing_utils.dart';
import 'package:xayn_design/src/widget/nav_bar/nav_bar.dart';

void main() {
  final route = MaterialPageRoute(builder: (_) => const Center());
  test(
    'GIVEN observer WHEN context is null THEN resetNavBar not called',
    () {
      var wasCalled = false;
      void reset(
        BuildContext context, {
        required bool goingBack,
      }) {
        wasCalled = true;
      }

      final observer = NavBarObserver.test(reset);

      observer.didPop(route, null);
      observer.didPush(route, null);
      observer.didRemove(route, null);
      observer.didReplace();

      expect(wasCalled, isFalse);
    },
  );
  testWidgets(
    'GIVEN observer WHEN navigator.pop THEN resetNavBar is called with isGoingBack == true',
    (final WidgetTester tester) async {
      bool? isGoingBack;
      void reset(
        BuildContext context, {
        required bool goingBack,
      }) {
        isGoingBack = goingBack;
      }

      final observer = NavBarObserver.test(reset);
      await tester.pumpLindenApp(const Center(), observers: [observer]);

      observer.didPop(route, null);
      expect(isGoingBack, isTrue);
    },
  );
  testWidgets(
    'GIVEN observer WHEN navigator.push THEN resetNavBar is called with isGoingBack == false',
    (final WidgetTester tester) async {
      bool? isGoingBack;
      void reset(
        BuildContext context, {
        required bool goingBack,
      }) {
        isGoingBack = goingBack;
      }

      final observer = NavBarObserver.test(reset);
      await tester.pumpLindenApp(const Center(), observers: [observer]);

      observer.didPush(route, null);
      expect(isGoingBack, isFalse);
    },
  );
  testWidgets(
    'GIVEN observer WHEN navigator.didRemove THEN resetNavBar is called with isGoingBack == false',
    (final WidgetTester tester) async {
      bool? isGoingBack;
      void reset(
        BuildContext context, {
        required bool goingBack,
      }) {
        isGoingBack = goingBack;
      }

      final observer = NavBarObserver.test(reset);
      await tester.pumpLindenApp(const Center(), observers: [observer]);

      observer.didRemove(route, null);
      expect(isGoingBack, isFalse);
    },
  );
  testWidgets(
    'GIVEN observer WHEN navigator.didReplace THEN resetNavBar is called with isGoingBack == false',
    (final WidgetTester tester) async {
      bool? isGoingBack;
      void reset(
        BuildContext context, {
        required bool goingBack,
      }) {
        isGoingBack = goingBack;
      }

      final observer = NavBarObserver.test(reset);
      await tester.pumpLindenApp(const Center(), observers: [observer]);

      observer.didReplace();
      expect(isGoingBack, isFalse);
    },
  );
}
