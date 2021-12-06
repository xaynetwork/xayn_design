import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/xayn_design.dart';

mixin NavBarConfigMixin {
  /// If value is null - the previous in a tree [NavBarConfig] will be applied
  /// If value is  not null - config will be shown.
  /// If need to hide previous config, and show nothing
  ///   (hide [NavBar] while widget shown) - use [NavBarConfig.hidden]
  NavBarConfig? get navBarConfig;
}
