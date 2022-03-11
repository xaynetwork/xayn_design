import 'package:flutter/material.dart';

/// The [XAnimations] holds different `Duration` units that are used in
/// animations
///
/// Accessed through [Linden].
@immutable
class XAnimations {
  final Duration _unit;
  const XAnimations() : _unit = const Duration(milliseconds: 200);

  /// The swipe velocity which is required to trigger a "fling" gesture.
  double get flingVelocity => 2000.0;

  Duration get unit => _unit;

  Duration get unit1_5 => _unit * 1.5;

  Duration get unit2 => _unit * 2;

  Duration get unit2_5 => _unit * 2.5;

  Duration get unit3 => _unit * 3;

  Duration get unit5 => _unit * 5;

  Duration get unit10 => _unit * 10;

  Duration get unit15 => _unit * 15;

  Duration get unit25 => _unit * 25;

  Duration get searchBarAnimation => unit;

  Curve get searchBarCurve => Curves.easeInOut;

  Duration get searchBarCentered => unit;

  Duration get mainScreenPageTransition => unit3;

  Duration get dialogTransition => unit1_5;

  Duration get onboadingPageAnimation => unit;

  Duration get onboardingOpacityAnimation => unit5;

  Duration get onboardingSlideAnimation => unit10;

  Duration get onboardingInitialAnimation => unit5;

  Duration get onboardingTotalSwipeAnimation => unit15;

  Duration get onboardingScrollAnimation => unit25;

  Duration get tooltipTimeToLive => unit10;

  Duration get cardTransitionDuration => unit3;

  Duration get screenStateChangeDuration => _unit;

  Duration get feedTransitionDuration => _unit * 4;

  Duration get cardSnapBackDuration => _unit * 2.5;
  Duration get cardOpenTransitionDuration => _unit * 5;
  Duration get cardCloseTransitionDuration => _unit * 3;

  Curve get snapBackToFeedCurve => Curves.elasticOut;
}
