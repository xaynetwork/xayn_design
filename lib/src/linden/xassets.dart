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

  String get brainyEnabled => _theme(
        brightAsset: 'assets/illustrations/brainy_enabled.svg',
        darkAsset: 'assets/illustrations/brainy_enabled_dark.svg',
      );

  String get brainyDisabled => _theme(
        brightAsset: 'assets/illustrations/brainy_disabled.svg',
        darkAsset: 'assets/illustrations/brainy_disabled_dark.svg',
      );

  String get enableCamera =>
      packagePath + 'assets/illustrations/enable_camera.svg';

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
  String get formsGreen => packagePath + 'assets/graphics/forms_green.svg';

  String get formsOrange => packagePath + 'assets/graphics/forms_orange.svg';

  String get formsPurple => packagePath + 'assets/graphics/forms_purple.svg';

  String get gridView => packagePath + 'assets/graphics/grid_view.svg';

  String get listView => packagePath + 'assets/graphics/list_view.svg';

  String get newsOnly => packagePath + 'assets/graphics/news_only.svg';

  String get searchNews => packagePath + 'assets/graphics/search_news.svg';

  String get searchOnly => packagePath + 'assets/graphics/search_only.svg';
}

class _Icons {
  final Brightness _brightness;

  const _Icons(this._brightness);

  String get alert => _theme(brightAsset: 'assets/icons/alert.svg');

  String get arrowDown => _theme(brightAsset: 'assets/icons/arrow_down.svg');

  String get arrowLeft => _theme(brightAsset: 'assets/icons/arrow_left.svg');

  String get arrowRight => _theme(brightAsset: 'assets/icons/arrow_right.svg');

  String get arrowUp => _theme(brightAsset: 'assets/icons/arrow_up.svg');

  String get binoculars => _theme(brightAsset: 'assets/icons/binoculars.svg');

  String get book => _theme(brightAsset: 'assets/icons/book.svg');

  String get bookmark => _theme(brightAsset: 'assets/icons/bookmark.svg');

  String get bookmarkActive =>
      _theme(brightAsset: 'assets/icons/bookmark_active.svg');

  String get bug => _theme(brightAsset: 'assets/icons/bug.svg');

  String get carousel => _theme(brightAsset: 'assets/icons/carousel.svg');

  String get check => _theme(brightAsset: 'assets/icons/check.svg');

  String get clock => _theme(brightAsset: 'assets/icons/clock.svg');

  String get confetti => _theme(brightAsset: 'assets/icons/confetti.svg');

  String get cross => _theme(brightAsset: 'assets/icons/cross.svg');

  String get devices => _theme(brightAsset: 'assets/icons/devices.svg');

  String get download => _theme(brightAsset: 'assets/icons/download.svg');

  String get edit => _theme(brightAsset: 'assets/icons/edit.svg');

  String get filters => _theme(brightAsset: 'assets/icons/filters.svg');

  String get filtersIconRound =>
      _theme(brightAsset: 'assets/icons/filters_round.svg');

  String get gear => _theme(brightAsset: 'assets/icons/gear.svg');

  String get globe => _theme(brightAsset: 'assets/icons/globe.svg');

  String get heart => _theme(brightAsset: 'assets/icons/heart.svg');

  /// AppBottomNavigationBar
  String get home => _theme(brightAsset: 'assets/icons/home.svg');

  String get image => _theme(brightAsset: 'assets/icons/image.svg');

  String get info => _theme(brightAsset: 'assets/icons/info.svg');

  String get language => _theme(brightAsset: 'assets/icons/language.svg');

  String get legal => _theme(brightAsset: 'assets/icons/legal.svg');

  String get lightening => _theme(brightAsset: 'assets/icons/lightening.svg');

  String get list => _theme(brightAsset: 'assets/icons/list.svg');

  String get loading => _theme(brightAsset: 'assets/icons/loading.svg');

  String get locationPin =>
      _theme(brightAsset: 'assets/icons/location_pin.svg');

  String get map => _theme(brightAsset: 'assets/icons/map.svg');

  String get menu => _theme(brightAsset: 'assets/icons/menu.svg');

  String get minus => _theme(brightAsset: 'assets/icons/minus.svg');

  String get moon => _theme(brightAsset: 'assets/icons/moon.svg');

  String get moonAndSun => _theme(brightAsset: 'assets/icons/moon_and_sun.svg');

  String get neutral => _theme(brightAsset: 'assets/icons/neutral.svg');

  String get newTab => _theme(brightAsset: 'assets/icons/new_tab.svg');

  String get news => _theme(brightAsset: 'assets/icons/news.svg');

  String get notification =>
      _theme(brightAsset: 'assets/icons/notification.svg');

  String get person => _theme(brightAsset: 'assets/icons/person.svg');

  String get phone => _theme(brightAsset: 'assets/icons/phone.svg');

  String get plant => _theme(brightAsset: 'assets/icons/plant.svg');

  String get play => _theme(brightAsset: 'assets/icons/play.svg');

  String get plus => _theme(brightAsset: 'assets/icons/plus.svg');

  String get qrCode => _theme(brightAsset: 'assets/icons/qr_code.svg');

  String get qrScan => _theme(brightAsset: 'assets/icons/qr_scanner.svg');

  String get readerMode => _theme(brightAsset: 'assets/icons/reader_mode.svg');

  String get reload => _theme(brightAsset: 'assets/icons/reload.svg');

  String get rocket => _theme(brightAsset: 'assets/icons/rocket.svg');

  String get search => _theme(brightAsset: 'assets/icons/search.svg');

  String get share => _platformDepended(
        iOSAsset: 'assets/icons/share_ios.svg',
        androidAsset: 'assets/icons/share_android.svg',
      );

  String get shield => _theme(brightAsset: 'assets/icons/shield.svg');

  String get speechBubbles =>
      _theme(brightAsset: 'assets/icons/speech_bubbles.svg');

  String get sun => _theme(brightAsset: 'assets/icons/sun.svg');

  String get tabs => _theme(brightAsset: 'assets/icons/tabs.svg');

  String get thumbsDown => _theme(brightAsset: 'assets/icons/thumbs_down.svg');

  String get thumbsDownActive =>
      _theme(brightAsset: 'assets/icons/thumbs_down_active.svg');

  String get thumbsUp => _theme(brightAsset: 'assets/icons/thumbs_up.svg');

  String get thumbsUpActive =>
      _theme(brightAsset: 'assets/icons/thumbs_up_active.svg');

  String get trash => _theme(brightAsset: 'assets/icons/trash.svg');

  String get undo => _theme(brightAsset: 'assets/icons/undo.svg');

  String get video => _theme(brightAsset: 'assets/icons/video.svg');

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
