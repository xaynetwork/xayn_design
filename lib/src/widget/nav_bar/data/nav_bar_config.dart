import 'package:equatable/equatable.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';
import 'package:xayn_design/src/widget/nav_bar/nav_bar.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';

enum NavBarType {
  card,
  backBtn,
  hidden,
  ignored,
}

class NavBarConfig extends Equatable {
  /// List of items, that will be shown inside [NavBar]
  final List<NavBarItem> items;

  /// If [true] than [NavBar] width will be expanded to the possible maximum
  /// and items in a [Row] will be placed with [MainAxisAlignment.spaceBetween]
  final bool isWidthExpanded;
  final NavBarType type;

  const NavBarConfig._(
    this.items,
    this.isWidthExpanded,
    this.type,
  );

  const NavBarConfig(
    this.items, {
    this.isWidthExpanded = false,
  })  : assert(items.length > 0, 'There should be at least one item'),
        type = NavBarType.card;

  /// Use this constructor, if you need to hide [NavBar]
  /// when widget that use [NavBarConfig] is shown
  factory NavBarConfig.hidden() =>
      const NavBarConfig._([], false, NavBarType.hidden);

  /// Use this constructor, if you need to ignore
  /// implementation of the [NavBarConfigMixin]
  /// In this case previous in the widget tree [NavBarConfigMixin] will be used
  factory NavBarConfig.ignored() =>
      const NavBarConfig._([], false, NavBarType.ignored);

  NavBarConfig.backBtn(
    NavBarItemBackButton btn,
  )   : items = [btn],
        isWidthExpanded = false,
        type = NavBarType.backBtn;

  @override
  List<Object?> get props => [
        items,
        isWidthExpanded,
        type,
      ];
}

extension NavBarTypeExtension on NavBarType {
  bool get isCard => this == NavBarType.card;

  bool get isBack => this == NavBarType.backBtn;

  bool get isHidden => this == NavBarType.hidden;

  bool get isIgnored => this == NavBarType.ignored;
}
