import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const packagePath = 'packages/xayn_design/';

@immutable
class Assets {
  final Brightness _brightness;

  const Assets({Brightness? brightness})
      : _brightness = brightness ?? Brightness.light;

  // Alert
  String get alertIcon => _theme(brightAsset: 'assets/icons/icon_alert.svg');

  /// Avatar
  String avatarJson(Brightness brightness) => _theme(
        brightAsset: 'assets/lottie/avatar.json',
        darkAsset: 'assets/lottie/avatar_dark.json',
        forceBrightness: brightness,
      );

  String get avatarEnabledIcon => _theme(
        brightAsset: 'assets/icons/avatar_enabled.svg',
        darkAsset: 'assets/icons/avatar_enabled_dark.svg',
      );

  String get avatarDisabledIcon => _theme(
        brightAsset: 'assets/icons/avatar_disabled.svg',
        darkAsset: 'assets/icons/avatar_disabled_dark.svg',
      );

  /// SearchScreenResultList
  String get checkIcon => _theme(brightAsset: 'assets/icons/icon_check.svg');

  String get neutralIcon =>
      _theme(brightAsset: 'assets/icons/icon_neutral.svg');

  String get xIcon => _theme(brightAsset: 'assets/icons/icon_x.svg');

  String get plusIcon => _theme(brightAsset: 'assets/icons/icon_plus.svg');

  String get newTabIcon => _theme(brightAsset: 'assets/icons/icon_new_tab.svg');

  String get binocularsIcon =>
      _theme(brightAsset: 'assets/icons/icon_binoculars.svg');

  /// AppBottomNavigationBar
  String get homeIcon => _theme(brightAsset: 'assets/icons/icon_home.svg');

  String get searchIcon => _theme(brightAsset: 'assets/icons/icon_search.svg');

  String get largeSearchIcon =>
      _theme(brightAsset: 'assets/icons/icon_search_large.svg');

  ///Not used
  String get bookIcon => _theme(brightAsset: 'assets/icons/icon_book.svg');

  String get collectionsIcon =>
      _theme(brightAsset: 'assets/icons/icon_collections.svg');

  String get readerModeIcon =>
      _theme(brightAsset: 'assets/icons/icon_reader_mode.svg');

  String get tabsIcon => _theme(brightAsset: 'assets/icons/icon_tabs.svg');

  String get historyIcon =>
      _theme(brightAsset: 'assets/icons/icon_history.svg');

  String get settingsIcon =>
      _theme(brightAsset: 'assets/icons/icon_settings.svg');

  String get forwardIcon =>
      _theme(brightAsset: 'assets/icons/icon_forward.svg');

  String get backIcon => _theme(brightAsset: 'assets/icons/icon_back.svg');

  String get upIcon => _theme(brightAsset: 'assets/icons/icon_up.svg');

  String get downIcon => _theme(brightAsset: 'assets/icons/icon_down.svg');

  String get iconXayn => _theme(brightAsset: 'assets/icons/icon_logo.svg');

  String get iconMenu => _theme(brightAsset: 'assets/icons/icon_menu.svg');

  /// AppLogo
  String get xaynLogo => _theme(brightAsset: 'assets/xayn_logo.svg');

  /// PersonalisationToggle
  String get personIcon => _theme(brightAsset: 'assets/icons/icon_person.svg');

  String get hintArrow => _theme(brightAsset: 'assets/icons/hint_arrow.svg');

  /// SearchTypeButton
  String get webIcon => _theme(brightAsset: 'assets/icons/icon_web.svg');

  String get webThreeDotsIcon =>
      _theme(brightAsset: 'assets/icons/icon_web_three_dots.svg');

  String get imageIcon => _theme(brightAsset: 'assets/icons/icon_image.svg');

  String get videoIcon => _theme(brightAsset: 'assets/icons/icon_video.svg');

  String get imageThreeDotsIcon =>
      _theme(brightAsset: 'assets/icons/icon_image_three_dots.svg');

  String get videoThreeDotsIcon =>
      _theme(brightAsset: 'assets/icons/icon_video_three_dots.svg');

  String get newsIcon => _theme(brightAsset: 'assets/icons/icon_news.svg');

  String get newsThreeDotsIcon =>
      _theme(brightAsset: 'assets/icons/icon_news_three_dots.svg');

  /// HistoryScreenButtons
  String get trashIcon => _theme(brightAsset: 'assets/icons/icon_trash.svg');

  String get filtersIcon =>
      _theme(brightAsset: 'assets/icons/icon_filters.svg');

  String get filtersIconRound =>
      _theme(brightAsset: 'assets/icons/icon_filters_round.svg');

  /// Swipeable
  String get bookmarkIcon =>
      _theme(brightAsset: 'assets/icons/icon_bookmark.svg');

  String get bookmarkActiveIcon =>
      _theme(brightAsset: 'assets/icons/icon_bookmark_active.svg');

  String get shareIcon => _platformDepended(
        iOSAsset: 'assets/icons/icon_share.svg',
        androidAsset: 'assets/icons/icon_share_android.svg',
      );

  String get editIcon => _theme(brightAsset: 'assets/icons/icon_edit.svg');

  String get undoIcon => _theme(brightAsset: 'assets/icons/icon_undo.svg');

  String get downloadIcon =>
      _theme(brightAsset: 'assets/icons/icon_download.svg');

  /// SettingsScreen
  String get marketChangeIcon =>
      _theme(brightAsset: 'assets/icons/icon_market_change.svg');

  String get infoIcon => _theme(brightAsset: 'assets/icons/icon_info.svg');

  String get legalIcon => _theme(brightAsset: 'assets/icons/icon_legal.svg');

  String get bugIcon => _theme(brightAsset: 'assets/icons/icon_bug.svg');

  String get shieldIcon => _theme(brightAsset: 'assets/icons/icon_shield.svg');

  String get boltIcon => _theme(brightAsset: 'assets/icons/icon_bolt.svg');

  String get rocketIcon => _theme(brightAsset: 'assets/icons/icon_rocket.svg');

  String get osModeIcon => _theme(brightAsset: 'assets/icons/icon_mode_os.svg');

  String get lightModeIcon =>
      _theme(brightAsset: 'assets/icons/icon_mode_light.svg');

  String get darkModeIcon =>
      _theme(brightAsset: 'assets/icons/icon_mode_dark.svg');

  String get syncDevicesIcon =>
      _theme(brightAsset: 'assets/icons/icon_sync_devices.svg');

  String get qrScanIcon =>
      _theme(brightAsset: 'assets/icons/icon_qr_scanner.svg');

  String get enableCameraIllustration =>
      _theme(brightAsset: 'assets/icons/illustration_enable_camera.svg');

  String get qrCodeIcon => _theme(brightAsset: 'assets/icons/icon_qr_code.svg');

  String get minusIcon => _theme(brightAsset: 'assets/icons/icon_minus.svg');

  String get cancelIcon => _theme(brightAsset: 'assets/icons/icon_cancel.svg');

  /// NewsFeed Screen Layout
  String get layoutSearchNewsSelected =>
      _theme(brightAsset: 'assets/icons/layout_search_news_selected.svg');

  String get layoutSearchNews =>
      _theme(brightAsset: 'assets/icons/layout_search_news.svg');

  String get layoutSearchOnlySelected =>
      _theme(brightAsset: 'assets/icons/layout_search_only_selected.svg');

  String get layoutSearchOnly =>
      _theme(brightAsset: 'assets/icons/layout_search_only.svg');

  String get layoutNewsOnlySelected =>
      _theme(brightAsset: 'assets/icons/layout_news_only_selected.svg');

  String get layoutNewsOnly =>
      _theme(brightAsset: 'assets/icons/layout_news_only.svg');

  /// Grid Setup Layout
  String get gridView =>
      _theme(brightAsset: 'assets/icons/layout_grid_view_option.svg');

  String get gridViewSelected =>
      _theme(brightAsset: 'assets/icons/layout_grid_view_option_selected.svg');

  String get listView =>
      _theme(brightAsset: 'assets/icons/layout_list_view_option.svg');

  String get listViewSelected =>
      _theme(brightAsset: 'assets/icons/layout_list_view_option_selected.svg');

  /// WebView
  String get webDial => _theme(brightAsset: 'assets/icons/icon_web_dial.svg');

  String get webShareExternally =>
      _theme(brightAsset: 'assets/icons/icon_web_share_externally.svg');

  String get webShare => _platformDepended(
        iOSAsset: 'assets/icons/icon_web_share.svg',
        androidAsset: 'assets/icons/icon_share_android.svg',
      );

  String get webBookmark =>
      _theme(brightAsset: 'assets/icons/icon_web_bookmark.svg');

  String get webBookmarkActive =>
      _theme(brightAsset: 'assets/icons/icon_web_bookmark_active.svg');

  String get thumbsUp => _theme(brightAsset: 'assets/icons/icon_thumbs_up.svg');

  String get thumbsDown =>
      _theme(brightAsset: 'assets/icons/icon_thumbs_down.svg');

  /// Video tab
  String get videoPlay =>
      _theme(brightAsset: 'assets/icons/icon_video_play.svg');

  ///NewsFeed screen
  String get saluteIcon => _theme(brightAsset: 'assets/icons/icon_salute.svg');

  // Webview
  String get reload => _theme(brightAsset: 'assets/icons/icon_reload.svg');

  String _platformDepended({
    required String iOSAsset,
    required String androidAsset,
  }) {
    final asset = SafePlatform.isAndroid ? androidAsset : iOSAsset;
    return packagePath + asset;
  }

  String _theme({
    required String brightAsset,
    String? darkAsset,
    Brightness? forceBrightness,
  }) {
    final isDark = (forceBrightness ?? _brightness) == Brightness.dark;
    final asset = isDark ? (darkAsset ?? brightAsset) : brightAsset;
    return packagePath + asset;
  }
}
