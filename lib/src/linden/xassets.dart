import 'package:flutter/material.dart';
import '../utils/safe_platform.dart';

/// All the assets' strings should be preceded by [packagePath]
const packagePath = 'packages/xayn_design/';

/// The [XStyles] exposes `String`s of shared assets
///
/// Accessed through [Linden].
@immutable
class XAssets {
  final Brightness _brightness;

  const XAssets({Brightness? brightness})
      : _brightness = brightness ?? Brightness.light;

  _Lottie get lottie => _Lottie(_brightness);

  _Icons get icons => _Icons(_brightness);

  _Illustrations get illustrations => _Illustrations(_brightness);

  _Graphics get graphics => _Graphics();

  _Logo get logo => _Logo();
}

class _Lottie {
  final Brightness _brightness;

  const _Lottie(this._brightness);

  String brainyJson(Brightness brightness) => _theme(
        brightAsset: 'assets/lottie/brainy.json',
        darkAsset: 'assets/lottie/brainy_dark.json',
        brightness: brightness,
      );

  String _theme({
    required String brightAsset,
    String? darkAsset,
    Brightness? brightness,
  }) {
    final isDark = (brightness ?? _brightness) == Brightness.dark;
    final asset = isDark ? (darkAsset ?? brightAsset) : brightAsset;
    return packagePath + asset;
  }
}

class _Logo {
  String get xayn => packagePath + 'assets/logo/xayn_logo.svg';

  String get xaynIcon => packagePath + 'assets/logo/icon_logo.svg';
}

class _Illustrations {
  final Brightness _brightness;

  const _Illustrations(this._brightness);

  String get enableCamera =>
      packagePath + 'assets/illustrations/illustration_enable_camera.svg';

  String get brainyEnabled => _theme(
        brightAsset: 'assets/icons/brainy_enabled.svg',
        darkAsset: 'assets/icons/brainy_enabled_dark.svg',
      );

  String get brainyDisabled => _theme(
        brightAsset: 'assets/icons/brainy_disabled.svg',
        darkAsset: 'assets/icons/brainy_disabled_dark.svg',
      );

  String _theme({
    required String brightAsset,
    String? darkAsset,
    Brightness? brightness,
  }) {
    final isDark = (brightness ?? _brightness) == Brightness.dark;
    final asset = isDark ? (darkAsset ?? brightAsset) : brightAsset;
    return packagePath + asset;
  }
}

class _Graphics {
  String get searchNews =>
      packagePath + 'assets/graphics/graphic_search_news.svg';

  String get searchOnly =>
      packagePath + 'assets/graphics/graphic_search_only.svg';

  String get newsOnly => packagePath + 'assets/graphics/graphic_news_only.svg';

  String get gridView => packagePath + 'assets/graphics/graphic_grid_view.svg';

  String get listView => packagePath + 'assets/graphics/graphic_list_view.svg';
}

class _Icons {
  final Brightness _brightness;

  const _Icons(this._brightness);

  String get alert => _theme(brightAsset: 'assets/icons/icon_alert.svg');

  String get check => _theme(brightAsset: 'assets/icons/icon_check.svg');

  String get neutral => _theme(brightAsset: 'assets/icons/icon_neutral.svg');

  String get cross => _theme(brightAsset: 'assets/icons/icon_cross.svg');

  String get plus => _theme(brightAsset: 'assets/icons/icon_plus.svg');

  String get newTab => _theme(brightAsset: 'assets/icons/icon_new_tab.svg');

  String get binoculars =>
      _theme(brightAsset: 'assets/icons/icon_binoculars.svg');

  /// AppBottomNavigationBar
  String get home => _theme(brightAsset: 'assets/icons/icon_home.svg');

  String get search => _theme(brightAsset: 'assets/icons/icon_search.svg');

  String get book => _theme(brightAsset: 'assets/icons/icon_book.svg');

  String get readerMode =>
      _theme(brightAsset: 'assets/icons/icon_reader_mode.svg');

  String get tabs => _theme(brightAsset: 'assets/icons/icon_tabs.svg');

  String get clock => _theme(brightAsset: 'assets/icons/icon_clock.svg');

  String get gear => _theme(brightAsset: 'assets/icons/icon_gear.svg');

  String get forward => _theme(brightAsset: 'assets/icons/icon_forward.svg');

  String get back => _theme(brightAsset: 'assets/icons/icon_back.svg');

  String get up => _theme(brightAsset: 'assets/icons/icon_up.svg');

  String get down => _theme(brightAsset: 'assets/icons/icon_down.svg');

  String get menu => _theme(brightAsset: 'assets/icons/icon_menu.svg');

  String get person => _theme(brightAsset: 'assets/icons/icon_person.svg');

  String get globe => _theme(brightAsset: 'assets/icons/icon_globe.svg');

  String get image => _theme(brightAsset: 'assets/icons/icon_image.svg');

  String get video => _theme(brightAsset: 'assets/icons/icon_video.svg');

  String get news => _theme(brightAsset: 'assets/icons/icon_news.svg');

  String get trash => _theme(brightAsset: 'assets/icons/icon_trash.svg');

  String get filters => _theme(brightAsset: 'assets/icons/icon_filters.svg');

  String get filtersIconRound =>
      _theme(brightAsset: 'assets/icons/icon_filters_round.svg');

  String get bookmark => _theme(brightAsset: 'assets/icons/icon_bookmark.svg');

  String get bookmarkActive =>
      _theme(brightAsset: 'assets/icons/icon_bookmark_active.svg');

  String get share => _platformDepended(
        iOSAsset: 'assets/icons/icon_share_ios.svg',
        androidAsset: 'assets/icons/icon_share_android.svg',
      );

  String get edit => _theme(brightAsset: 'assets/icons/icon_edit.svg');

  String get undo => _theme(brightAsset: 'assets/icons/icon_undo.svg');

  String get download => _theme(brightAsset: 'assets/icons/icon_download.svg');

  String get speechBubbles =>
      _theme(brightAsset: 'assets/icons/icon_speech_bubbles.svg');

  String get info => _theme(brightAsset: 'assets/icons/icon_info.svg');

  String get legal => _theme(brightAsset: 'assets/icons/icon_legal.svg');

  String get bug => _theme(brightAsset: 'assets/icons/icon_bug.svg');

  String get shield => _theme(brightAsset: 'assets/icons/icon_shield.svg');

  String get lightening =>
      _theme(brightAsset: 'assets/icons/icon_lightening.svg');

  String get rocket => _theme(brightAsset: 'assets/icons/icon_rocket.svg');

  String get moonAndSun =>
      _theme(brightAsset: 'assets/icons/icon_moon_and_sun.svg');

  String get sun => _theme(brightAsset: 'assets/icons/icon_sun.svg');

  String get moon => _theme(brightAsset: 'assets/icons/icon_moon.svg');

  String get devices => _theme(brightAsset: 'assets/icons/icon_devices.svg');

  String get qrScan => _theme(brightAsset: 'assets/icons/icon_qr_scanner.svg');

  String get qrCode => _theme(brightAsset: 'assets/icons/icon_qr_code.svg');

  String get minus => _theme(brightAsset: 'assets/icons/icon_minus.svg');

  String get cancel => _theme(brightAsset: 'assets/icons/icon_cancel.svg');

  String get reload => _theme(brightAsset: 'assets/icons/icon_reload.svg');

  String get thumbsUp => _theme(brightAsset: 'assets/icons/icon_thumbs_up.svg');

  String get thumbsDown =>
      _theme(brightAsset: 'assets/icons/icon_thumbs_down.svg');

  String get play => _theme(brightAsset: 'assets/icons/icon_play.svg');

  String get confetti => _theme(brightAsset: 'assets/icons/icon_confetti.svg');

  String get heart => _theme(brightAsset: 'assets/icons/icon_heart.svg');

  String _theme({
    required String brightAsset,
    String? darkAsset,
    Brightness? brightness,
  }) {
    final isDark = (brightness ?? _brightness) == Brightness.dark;
    final asset = isDark ? (darkAsset ?? brightAsset) : brightAsset;
    return packagePath + asset;
  }
}

String _platformDepended({
  required String iOSAsset,
  required String androidAsset,
}) {
  final asset = SafePlatform.isAndroid ? androidAsset : iOSAsset;
  return packagePath + asset;
}
