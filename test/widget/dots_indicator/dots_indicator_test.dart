import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

import '../../utils/widget_test_utils.dart';

void main() {
  test(
    'GIVEN widget with zero dots THEN throw assertion error',
    () {
      expect(
        () => DotsIndicator(
          dotsNumber: 0,
          activePosition: 0,
        ),
        throwsA(isA<AssertionError>()),
      );
    },
  );

  test(
    'GIVEN widget with active position bigger than number dots THEN throw assertion error',
    () {
      expect(
        () => DotsIndicator(
          dotsNumber: 3,
          activePosition: 4,
        ),
        throwsA(isA<AssertionError>()),
      );
    },
  );

  test(
    'GIVEN widget with active position equal to the number dots THEN throw assertion error',
    () {
      expect(
        () => DotsIndicator(
          dotsNumber: 3,
          activePosition: 3,
        ),
        throwsA(isA<AssertionError>()),
      );
    },
  );

  testWidgets(
    'GIVEN proper dotsNumber and activePosition values THEN render object with correct number of dots',
    (final WidgetTester tester) async {
      const dotsNumber = 3;

      await tester.pumpAppWrapped(const DotsIndicator(
        dotsNumber: dotsNumber,
        activePosition: 1,
      ));

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Container), findsNWidgets(dotsNumber));
    },
  );
}
