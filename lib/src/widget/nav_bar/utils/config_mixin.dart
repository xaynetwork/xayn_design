import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/xayn_design.dart';

mixin NavBarConfigMixin {
  /// This config will be used to shown data in the [NavBar]
  /// To show back button - use [NavBarConfig.backBtn]
  /// To hide [NavBar] for some screen/widget (make it invisible) - use [NavBarConfig.hidden]
  /// To ignore the implementation of [NavBarConfigMixin] - use [NavBarConfig.ignored].
  ///   In that case the previous in the widget tree [NavBarConfigMixin] will be used
  ///
  /// For more info please check [NavBarConfig]
  ///
  /// Should be used with [StatelessWidget] or with the [State] of [StatefulWidget]
  NavBarConfig get navBarConfig;
}
