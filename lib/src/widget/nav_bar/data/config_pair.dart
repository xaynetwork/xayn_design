import 'package:equatable/equatable.dart';
import 'package:xayn_design/src/widget/nav_bar/utils/config_mixin.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';

class ConfigPair extends Equatable {
  final ConfigUpdater updater;
  final NavBarConfigMixin? configMixin;

  const ConfigPair(
    this.updater,
    this.configMixin,
  );

  @override
  List<Object?> get props => [updater, configMixin];
}
