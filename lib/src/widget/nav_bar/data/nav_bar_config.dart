import 'package:equatable/equatable.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar.dart';

enum NavBarType {
  card,
  backBtn,
}

class NavBarConfig extends Equatable {
  /// If list is empty, than [NavBar] will be hidden
  final List<NavBarItem> items;

  /// If [true] than [NavBar] width will be expanded to the possible maximum
  /// and items in a [Row] will be placed with [MainAxisAlignment.spaceBetween]
  final bool isWidthExpanded;
  final NavBarType type;

  const NavBarConfig(
    this.items, {
    this.isWidthExpanded = false,
  }) : type = NavBarType.card;

  /// Use this constructor, if you need to hide [NavBar]
  /// when widget that use [NavBarConfig] is shown
  factory NavBarConfig.hidden() => const NavBarConfig([]);

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
