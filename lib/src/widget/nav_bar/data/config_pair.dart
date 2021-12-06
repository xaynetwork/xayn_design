import 'package:equatable/equatable.dart';
import 'package:xayn_design/src/widget/nav_bar/utils/config_mixin.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';

class ConfigPair extends Equatable {
  final ConfigUpdater updater;
  final List<NavBarConfigMixin> configMixins;

  const ConfigPair(
    this.updater,
    this.configMixins,
  );

  @override
  List<Object?> get props => [
        updater,
        configMixins,
      ];
}
