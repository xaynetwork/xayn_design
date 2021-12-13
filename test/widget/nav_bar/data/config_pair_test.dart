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
      const pair = ConfigPair(_FakeConfigUpdater(), []);
      expect(pair, isA<Equatable>());
    },
  );
  test(
    'GIVEN configPair THEN props are correct',
    () {
      const pair = ConfigPair(_FakeConfigUpdater(), [
        _NavBarConfigMixinHidden(),
        _NavBarConfigMixinHidden(),
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

class _FakeConfigUpdater implements ConfigUpdater {
  const _FakeConfigUpdater();

  @override
  void update(NavBarConfig? config) {}
}

class _NavBarConfigMixinHidden with NavBarConfigMixin {
  const _NavBarConfigMixinHidden();

  @override
  NavBarConfig get navBarConfig => NavBarConfig.hidden();
}
