import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xayn_design/src/widget/nav_bar/data/config_pair.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/nav_bar.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';

void main() {
  test(
    'GIVEN configPair THEN verify it extends Equatable',
    () {
      const pair = ConfigPair(FakeConfigUpdater(), []);
      expect(pair, isA<Equatable>());
    },
  );
  test(
    'GIVEN configPair THEN props are correct',
    () {
      const pair = ConfigPair(FakeConfigUpdater(), [
        NavBarConfigMixinHidden(),
        NavBarConfigMixinHidden(),
      ]);
      expect(
        pair.props,
        [
          pair.updater,
          pair.configMixins,
        ],
      );
    },
  );
}

class FakeConfigUpdater implements ConfigUpdater {
  const FakeConfigUpdater();

  @override
  void update(NavBarConfig? config) {}
}

class NavBarConfigMixinHidden with NavBarConfigMixin {
  const NavBarConfigMixinHidden();

  @override
  NavBarConfig get navBarConfig => NavBarConfig.hidden();
}
