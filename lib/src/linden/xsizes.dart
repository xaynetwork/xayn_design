import 'package:flutter/material.dart';

const int kTwoColumnsGrid = 2;
const int kThreeColumnsGrid = 3;
const int kFourColumnsGrid = 4;
const int kFiveColumnsGrid = 5;

const int kNumberOfSecondaryImagesMobile = 4;
const int kNumberOfSecondaryImagesTabletPortraitMode = 6;
const int kNumberOfSecondaryImagesTabletLandscapeMode = 8;

/// The [XSizes] describes dimensions
///
/// Accessed through [Linden].
@immutable
class XSizes {
  const XSizes({
    Size? screenSize,
    Orientation? deviceOrientation,
    double notchPaddingLandscapeMode = 0.0,
  })  : _screenSize = screenSize ?? const Size(800, 600),
        _deviceOrientation = deviceOrientation ?? Orientation.portrait,
        _notchPaddingLandscapeMode = notchPaddingLandscapeMode;

  final double _notchPaddingLandscapeMode;
  final Size _screenSize;
  final Orientation _deviceOrientation;

  static const _unit = 8.0;
  final double unit = _unit;
  final double unit0_25 = _unit * 0.25;
  final double unit0_5 = _unit * 0.5;
  final double unit0_75 = _unit * 0.75;
  final double unit1_5 = _unit * 1.5;
  final double unit2 = _unit * 2;
  final double unit2_25 = _unit * 2.25;
  final double unit2_5 = _unit * 2.5;
  final double unit2_75 = _unit * 2.75;
  final double unit3 = _unit * 3;
  final double unit4 = _unit * 4;
  final double unit5 = _unit * 5;
  final double unit6 = _unit * 6;
  final double unit7 = _unit * 7;
  final double unit8 = _unit * 8;
  final double unit9 = _unit * 9;
  final double unit10 = _unit * 10;
  final double unit11 = _unit * 11;
  final double unit12 = _unit * 12;
  final double unit15 = _unit * 15;
  final double unit20 = _unit * 20;
  final double unit21 = _unit * 21;
  final double unit22 = _unit * 22;
  final double unit29 = _unit * 29;
  final double unit48 = _unit * 48;
  final double unit52 = _unit * 52;

  /// breakpoints
  final double smallScreenWidth = 375;
  final double mobileTabletWidthBreakpoint = 600;
  final double maxContainerWidth = 1204; // 1140 + 32 * 2

  /// Material elevation values
  final double elevationHigh = 24;
  final double elevationLow = 10;

  /// On-boarding breakpoints & sizes
  final double onboardingScreenHeight = 900;
  final double onboardingCardWidth = 370;
  final double onboardingCardAverageHeight = 300;

  double get breakpoint320 => 320;

  double get breakpoint375 => 375;

  double get breakpoint621 => 621;

  double get breakpoint656 => 656;

  double get breakpoint768 => 768;

  double get breakpoint1024 => 1024;

  double get breakpoint1440 => 1440;

  double get screenWidth => _screenSize.width;

  bool get isSmallScreen => _screenSize.width <= smallScreenWidth;

  /// Screen width is larger than the medium content width
  bool get isMediumScreen => screenWidth > breakpoint656;

  bool get isMobile => _screenSize.shortestSide < mobileTabletWidthBreakpoint;

  bool get isTablet => !isMobile;

  bool get isMobilePortraitMode =>
      isMobile && _deviceOrientation == Orientation.portrait;

  bool get isMobileLandscapeMode =>
      isMobile && _deviceOrientation == Orientation.landscape;

  /// Return 0.0 if there is no notch
  double get deviceLandscapeModeNotchPadding => _notchPaddingLandscapeMode;

  bool get isTabletPortraitMode =>
      isTablet && _deviceOrientation == Orientation.portrait;

  bool get isTabletLandscapeMode =>
      isTablet && _deviceOrientation == Orientation.landscape;

  Size get screenSize => _screenSize;

  /// Return the number of columns to show in a grid view depending on
  /// the screen the user is experiencing (Experience) and the device and
  /// the orientation
  int gridViewCrossAxisCount(Experiences? experiences) {
    switch (experiences) {
      case Experiences.bookmarksScreen:
        if (isTabletLandscapeMode) {
          return kThreeColumnsGrid;
        } else {
          return kTwoColumnsGrid;
        }
      case Experiences.collectionsScreen:
      case Experiences.tabsScreen:
      case Experiences.imagesScreen:
        if (isMobilePortraitMode) {
          return kTwoColumnsGrid;
        } else if (isMobileLandscapeMode) {
          return kFourColumnsGrid;
        } else if (isTabletPortraitMode) {
          return kThreeColumnsGrid;
        } else {
          return kFiveColumnsGrid;
        }
      case Experiences.mainScreen:
      case Experiences.newsScreen:
      default:
        return kTwoColumnsGrid;
    }
  }

  /// Return the horizontal padding to set depending on the screen
  /// the user is experiencing (Experience) and the device and the orientation
  double deviceDependentHorizontalPadding(
      {Experiences experience = Experiences.notSpecified}) {
    switch (experience) {
      case Experiences.newsScreen:
      case Experiences.mainScreen:
        if (isMobileLandscapeMode) {
          return _screenSize.width * 0.1;
        } else {
          return _notchPaddingLandscapeMode;
        }
      case Experiences.imagesScreen:
        return _notchPaddingLandscapeMode;
      default:
        if (isMobilePortraitMode) {
          return 0.0;
        } else {
          return _screenSize.width * 0.1;
        }
    }
  }

  /// Return the number of images to show for the images section
  /// in the all results screen depending on the device and orientation
  int calculateImagesSecondaryResultsToShow() {
    if (isTabletPortraitMode) {
      return kNumberOfSecondaryImagesTabletPortraitMode;
    } else if (isTabletLandscapeMode) {
      return kNumberOfSecondaryImagesTabletLandscapeMode;
    } else {
      return kNumberOfSecondaryImagesMobile;
    }
  }

  int calculatePlaceHoldersNumForSkeletons({Experiences? experience}) {
    return gridViewCrossAxisCount(experience) * 3;
  }

  /// Provides unit for a given scale factor which is screen size dependent
  /// If small is not provided we assume normal / 2
  /// And by default normal is 1
  double adaptiveUnit({double normal = 1.0, double? small}) {
    return isSmallScreen || isMobileLandscapeMode
        ? (small ?? normal / 2) * _unit
        : normal * _unit;
  }

  double get iconSize => unit3;

  double get iconButtonSize => unit6;

  double get buttonMinHeight => unit5;

  double get buttonMinWidth => unit8;

  /// Bottom Bar
  double get bottomBarVerticalPadding => unit1_5;

  double get bottomBarDockedHeight => unit9;

  double get bottomBarHighlightHigh => unit0_5;

  double get bottomBarDockedThreshold {
    if (_deviceOrientation == Orientation.portrait) {
      return _screenSize.height * 0.3;
    } else {
      return _screenSize.height * 0.5;
    }
  }

  final double searchBarMaxWidth = 800.0;
  final double searchBarScrollThreshold = 150.0;

  final double headerMaxExtent = 65.0;

  ///graphics
  final double graphicsGridViewWidth = 149;
  final double graphicsNewsFeedLayoutWidth = 57;
  final double graphicsHeight = 93;

  final double disabledOpacity = 0.5;
}

/// Describes which configuration for certain [XSizes] attributes to use
enum Experiences {
  notSpecified,
  mainScreen,
  newsScreen,
  collectionsScreen,
  tabsScreen,
  bookmarksScreen,
  imagesScreen,
}
