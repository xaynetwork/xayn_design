// @dart=2.9
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:xayn_design/xayn_design.dart';

void main() {
  const mobile = Size(450, 800);
  const tablet = Size(750, 1100);
  Xayn xayn = Xayn();

  group('Device is a mobile in portrait mode', () {
    setUp(() {
      xayn = xayn.updateScreenInfo(
        screenSize: mobile,
        deviceOrientation: Orientation.portrait,
      );
    });

    test('the method isMobile should return true', () {
      final result = xayn.dimen.isMobile;
      expect(result, true);
    });

    test('the method isMobilePortraitMode should return true', () {
      final result = xayn.dimen.isMobilePortraitMode;
      expect(result, true);
    });

    test('the method isMobileLandscapeMode should return false', () {
      final result = xayn.dimen.isMobileLandscapeMode;
      expect(result, false);
    });

    test('the method isTablet should return false', () {
      final result = xayn.dimen.isTablet;
      expect(result, false);
    });

    test('the method isTabletPortraitMode should return false', () {
      final result = xayn.dimen.isTabletPortraitMode;
      expect(result, false);
    });

    test('the method isTabletLandscapeMode should return false', () {
      final result = xayn.dimen.isTabletLandscapeMode;
      expect(result, false);
    });
    test(
        'the method deviceDependentHorizontalPadding should return 0.0 when experience is not specified',
        () {
      final result = xayn.dimen.deviceDependentHorizontalPadding();
      expect(result, 0.0);
    });
  });

  group('Device is a mobile in landscape mode', () {
    setUp(() {
      xayn = xayn.updateScreenInfo(
        screenSize: mobile,
        deviceOrientation: Orientation.landscape,
      );
    });

    test('the method isMobile should return true', () {
      final result = xayn.dimen.isMobile;
      expect(result, true);
    });

    test('the method isMobilePortraitMode should return false', () {
      final result = xayn.dimen.isMobilePortraitMode;
      expect(result, false);
    });

    test('the method isMobileLandscapeMode should return true', () {
      final result = xayn.dimen.isMobileLandscapeMode;
      expect(result, true);
    });

    test('the method isTablet should return false', () {
      final result = xayn.dimen.isTablet;
      expect(result, false);
    });

    test('the method isTabletPortraitMode should return false', () {
      final result = xayn.dimen.isTabletPortraitMode;
      expect(result, false);
    });

    test('the method isTabletLandscapeMode should return false', () {
      final result = xayn.dimen.isTabletLandscapeMode;
      expect(result, false);
    });

    test(
        'build a four columns grid if the user is experiencing the all results images section',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.imagesScreen);
      expect(result, 4);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to the 10% of the width when experience is not specified',
        () {
      final result = xayn.dimen.deviceDependentHorizontalPadding();
      expect(result, mobile.width * 0.1);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to the 10% of the width if in MainScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.mainScreen);
      expect(result, mobile.width * 0.1);
    });

    test(
        'the method deviceDependentHorizontalPadding should return padding equivalent to the 10% of the width if in NewsScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.newsScreen);
      expect(result, mobile.width * 0.1);
    });
  });

  group('Device is a tablet in portrait mode', () {
    setUp(() {
      xayn = xayn.updateScreenInfo(
          screenSize: tablet, deviceOrientation: Orientation.portrait);
    });

    test('the method isMobile should return false', () {
      final result = xayn.dimen.isMobile;
      expect(result, false);
    });

    test('the method isMobilePortraitMode should return false', () {
      final result = xayn.dimen.isMobilePortraitMode;
      expect(result, false);
    });

    test('the method isMobileLandscapeMode should return false', () {
      final result = xayn.dimen.isMobileLandscapeMode;
      expect(result, false);
    });

    test('the method isTablet should return true', () {
      final result = xayn.dimen.isTablet;
      expect(result, true);
    });

    test('the method isTabletPortraitMode should return true', () {
      final result = xayn.dimen.isTabletPortraitMode;
      expect(result, true);
    });

    test('the method isTabletLandscapeMode should return false', () {
      final result = xayn.dimen.isTabletLandscapeMode;
      expect(result, false);
    });

    test('build a two columns grid if the user is experiencing the mainScreen',
        () {
      final result = xayn.dimen.gridViewCrossAxisCount(Experiences.mainScreen);
      expect(result, 2);
    });

    test(
        'build a two columns grid if the user is experiencing the bookmark screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.bookmarksScreen);
      expect(result, 2);
    });

    test(
        'build a three columns grid if the user is experiencing the collection screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.collectionsScreen);
      expect(result, 3);
    });

    test(
        'build a three columns grid if the user is experiencing the images screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.imagesScreen);
      expect(result, 3);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to the 10% of the width when experience is not specified',
        () {
      final result = xayn.dimen.deviceDependentHorizontalPadding();
      expect(result, tablet.width * 0.1);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to 0.0 if in MainScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.mainScreen);
      expect(result, 0.0);
    });

    test(
        'the method deviceDependentHorizontalPadding should return padding equivalent to 0.0 if in NewsScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.newsScreen);
      expect(result, 0.0);
    });
  });

  group('Device is a tablet in landscape mode', () {
    setUp(() {
      xayn = xayn.updateScreenInfo(
          screenSize: tablet, deviceOrientation: Orientation.landscape);
    });

    test('the method isMobile should return false', () {
      final result = xayn.dimen.isMobile;
      expect(result, false);
    });

    test('the method isMobilePortraitMode should return false', () {
      final result = xayn.dimen.isMobilePortraitMode;
      expect(result, false);
    });

    test('the method isMobileLandscapeMode should return false', () {
      final result = xayn.dimen.isMobileLandscapeMode;
      expect(result, false);
    });

    test('the method isTablet should return true', () {
      final result = xayn.dimen.isTablet;
      expect(result, true);
    });

    test('the method isTabletPortraitMode should return false', () {
      final result = xayn.dimen.isTabletPortraitMode;
      expect(result, false);
    });

    test('the method isTabletLandscapeMode should return true', () {
      final result = xayn.dimen.isTabletLandscapeMode;
      expect(result, true);
    });

    test('build a two columns grid if the user is experiencing the mainScreen',
        () {
      final result = xayn.dimen.gridViewCrossAxisCount(Experiences.mainScreen);
      expect(result, 2);
    });

    test(
        'build a three columns grid if the user is experiencing the bookmark screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.bookmarksScreen);
      expect(result, 3);
    });

    test(
        'build a five columns grid if the user is experiencing the collection screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.collectionsScreen);
      expect(result, 5);
    });

    test(
        'build a five columns grid if the user is experiencing the images screen',
        () {
      final result =
          xayn.dimen.gridViewCrossAxisCount(Experiences.imagesScreen);
      expect(result, 5);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to the 10% of the width when experience is not specified',
        () {
      final result = xayn.dimen.deviceDependentHorizontalPadding();
      expect(result, tablet.width * 0.1);
    });

    test(
        'the method deviceDependentHorizontalPadding should return a padding equivalent to 0.0 if in MainScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.mainScreen);
      expect(result, 0.0);
    });

    test(
        'the method deviceDependentHorizontalPadding should return padding equivalent to 0.0 if in NewsScreen',
        () {
      final result = xayn.dimen
          .deviceDependentHorizontalPadding(experience: Experiences.newsScreen);
      expect(result, 0.0);
    });
  });
}
