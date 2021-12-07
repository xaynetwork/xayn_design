import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  final mixin = _EmptyMixin();
  test(
    'GIVEN class with mixin THEN check mixin presence',
    () {
      expect(mixin, isA<NavBarConfigMixin>());
    },
  );
  test(
    'GIVEN class with mixin THEN check navBarConfig is not nullable',
    () {
      expect(mixin.navBarConfig, isNotNull);
    },
  );
  test(
    'GIVEN class with mixin THEN check navBarConfig is hidden',
    () {
      expect(mixin.navBarConfig, equals(NavBarConfig.hidden()));
    },
  );
}

class _EmptyMixin with NavBarConfigMixin {
  @override
  NavBarConfig get navBarConfig => NavBarConfig.hidden();
}
