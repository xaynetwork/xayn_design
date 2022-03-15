import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config_id.dart';

void main() {
  test(
    'GIVEN 2 id with same values WHEN compare equal THEN return true',
    () {
      const value = 'value';
      const first = NavBarConfigId(value);
      const second = NavBarConfigId(value);

      expect(first == second, isTrue);
    },
  );
  test(
    'GIVEN 2 id with different values WHEN compare equal THEN return false',
    () {
      const first = NavBarConfigId('value');
      const second = NavBarConfigId('value1');

      expect(first == second, isFalse);
    },
  );
  test(
    'GIVEN id WHEN toString called THEN return correct value',
    () {
      const id = NavBarConfigId('value');

      expect(id.toString(), equals('NavBarConfigId: value'));
    },
  );
}
