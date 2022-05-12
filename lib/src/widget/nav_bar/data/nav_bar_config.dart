import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:xayn_design/src/widget/nav_bar/nav_bar.dart';

enum NavBarType {
  card,
  backBtn,
  hidden,
  ignored,
}

@visibleForTesting
const idHidden = NavBarConfigId('hidden');

@visibleForTesting
const idIgnored = NavBarConfigId('ignored');

@visibleForTesting
const idBackBtn = NavBarConfigId('backBtn');

class NavBarConfig extends Equatable {
  /// Helps to compare configs with each other.
  final NavBarConfigId id;

  /// List of items, that will be shown inside [NavBar]
  final List<NavBarItem> items;

  /// If [true] than [NavBar] width will be expanded to the possible maximum
  /// and items in a [Row] will be placed with [MainAxisAlignment.spaceBetween]
  final bool isWidthExpanded;
  final NavBarType type;

  /// If [true] then the height of the keyboard will be added to
  /// the bottom padding of the [NavBar], so that it will be shown above it
  final bool showAboveKeyboard;

  const NavBarConfig._(
    this.id,
    this.items,
    this.isWidthExpanded,
    this.type,
    this.showAboveKeyboard,
  );

  NavBarConfig(
    this.id,
    this.items, {
    this.isWidthExpanded = false,
    this.showAboveKeyboard = true,
  })  : assert(
          items.isNotEmpty,
          'There should be at least one item',
        ),
        assert(
          items.where((element) => element.isHighlighted).length <= 1,
          'There can be maximum one highlighted item',
        ),
        assert(
          items.whereType<NavBarItemBackButton>().isEmpty,
          'BackButton item can be used only with the `.backBtn` constructor',
        ),
        type = NavBarType.card;

  /// Use this constructor, if you need to hide [NavBar]
  /// when widget that use [NavBarConfig] is shown
  factory NavBarConfig.hidden() =>
      const NavBarConfig._(idHidden, [], false, NavBarType.hidden, false);

  /// Use this constructor, if you need to ignore
  /// implementation of the [NavBarConfigMixin]
  /// In this case previous in the widget tree [NavBarConfigMixin] will be used
  factory NavBarConfig.ignored() =>
      const NavBarConfig._(idIgnored, [], false, NavBarType.ignored, false);

  NavBarConfig.backBtn(
    NavBarItemBackButton btn, {
    this.id = idBackBtn,
  })  : items = [btn],
        isWidthExpanded = false,
        showAboveKeyboard = false,
        type = NavBarType.backBtn;

  @override
  List<Object?> get props => [
        id,
        items,
        isWidthExpanded,
        type,
        showAboveKeyboard,
      ];
}

extension NavBarTypeExtension on NavBarType {
  bool get isCard => this == NavBarType.card;

  bool get isBack => this == NavBarType.backBtn;

  bool get isHidden => this == NavBarType.hidden;

  bool get isIgnored => this == NavBarType.ignored;
}
