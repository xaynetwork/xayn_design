import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

/// This mixin is just for private usage inside this package.
/// It should be used, when you need to build XAYN-related widget in respect
/// to the current [Linden].
///
/// As example, please check state of [TextualNotification]
mixin UnterDenLindenMixin<T extends StatefulWidget> on State<T> {
  /// Should be called ONLY inside the [build] method.
  /// If you will use it inside the builders - it might leak to the exception:
  /// ``` Looking up a deactivated widget's ancestor is unsafe.```
  Linden get linden => UnterDenLinden.getLinden(context);
}
