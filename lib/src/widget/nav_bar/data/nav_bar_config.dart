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

  NavBarConfig(
    this.items, {
    this.isWidthExpanded = false,
  })  : assert(
          items.where((element) => element.isHighlighted).length <= 1,
          'There can be maximum one highlighted item',
        ),
        type = NavBarType.card;

  /// Use this constructor, if you need to hide [NavBar]
  NavBarConfig.hide()
      : items = [],
        isWidthExpanded = false,
        type = NavBarType.backBtn;

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
