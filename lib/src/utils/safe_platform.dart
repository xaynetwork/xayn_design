import 'dart:io';

import 'package:flutter/foundation.dart';

/// Abstraction over [Platform], because calling [Platform] from
/// compiled web code, will throw a RTE.
class SafePlatform {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => kIsWeb ? false : Platform.isAndroid;

  static bool get isIOS => kIsWeb ? false : Platform.isIOS;

  static bool get isFuchsia => kIsWeb ? false : Platform.isFuchsia;

  static bool get isLinux => kIsWeb ? false : Platform.isLinux;

  static bool get isMacOS => kIsWeb ? false : Platform.isMacOS;

  static bool get isWindows => kIsWeb ? false : Platform.isWindows;
}
