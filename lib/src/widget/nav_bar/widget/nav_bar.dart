import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_config.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/back_button.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/edit.dart';
import 'package:xayn_design/src/widget/nav_bar/widget/nav_bar_item/icon_button.dart';
import 'package:xayn_design/xayn_design.dart';

const _defaultPadding = EdgeInsets.all(16);

class NavBar extends StatefulWidget {
  /// Padding, that applied around the [NavBar] content
  /// Apply only when config type is [NavBarType.card]
  final EdgeInsets padding;

  const NavBar({
    this.padding = _defaultPadding,
    Key? key,
  }) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

abstract class ConfigUpdater {
  void update(NavBarConfig? config);
}

class NavBarState extends State<NavBar> implements ConfigUpdater {
  Linden get linden => UnterDenLinden.getLinden(context);

  /// if configs is [null] - the empty [Center] will be build
  NavBarConfig? config;

  @override
  void update(NavBarConfig? config) {
    assert(
      config?.type != NavBarType.ignored,
      'This config is ignored, so it can not be used to update the NavBar. This is likely a internal Bug.',
    );

    setState(() {
      this.config = config;
      if (config != null) {
        assert(
          config.items.where((element) => element.isHighlighted).length <= 1,
          'There can be maximum one highlighted item',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = this.config;
    if (config == null || config.type.isHidden) return const Center();

    final items = config.items.map(_buildItem).toList(growable: false);

    if (config.type == NavBarType.backBtn) {
      return _withPadding(Row(children: [items.first]));
    }

    final row = Row(
      mainAxisSize:
          config.isWidthExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: config.isWidthExpanded
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: items,
    );

    final card = AppCardWidget(
      contentPadding: EdgeInsets.symmetric(horizontal: linden.dimen.unit),
      child: row,
      borderRadius: BorderRadius.all(Radius.circular(linden.dimen.unit1_5)),
      cardBackground: linden.colors.background,
    );

    final sized = SizedBox(
      child: Center(child: card),
      height: linden.dimen.navBarHeight,
    );

    return config.showAboveKeyboard
        ? _withPadding(sized, MediaQuery.of(context).viewInsets.bottom)
        : _withPadding(sized);
  }

  Widget _withPadding(Widget child, [double keyboardHeight = 0]) {
    final finalPadding = widget.padding.copyWith(
      bottom: widget.padding.bottom + keyboardHeight,
    );
    return SafeArea(
      child: Padding(
        padding: finalPadding,
        child: child,
      ),
    );
  }

  Widget _buildItem(NavBarItem data) {
    late final Widget child;
    switch (data.runtimeType) {
      case NavBarItemIconButton:
        child = NavBarIconButton(data as NavBarItemIconButton);
        break;
      case NavBarItemBackButton:
        child = NavBarBackButton(data as NavBarItemBackButton);
        break;
      case NavBarItemEdit:
        child = NavBarEdit(data as NavBarItemEdit);
        break;
      default:
        throw Exception('Unknown instance of $NavBarItem: ${data.runtimeType}');
    }

    final stack = Stack(
      children: [
        Center(child: child),
        data.isHighlighted ? const HighlightLine() : const Center(),
      ],
    );

    final isFirst = config!.items.first == data;
    final isLast = config!.items.last == data;
    final withPadding = Padding(
      padding: EdgeInsets.only(
        left: isFirst ? 0 : linden.dimen.unit0_5,
        right: isLast ? 0 : linden.dimen.unit0_5,
      ),
      child: stack,
    );

    if (data is NavBarItemEdit) {
      return Expanded(child: withPadding);
    }
    return withPadding;
  }
}

class HighlightLine extends StatelessWidget {
  const HighlightLine() : super(key: null);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final line = Container(
      height: linden.dimen.bottomBarHighlightHigh,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: linden.styles.roundBorderLargeTopSide,
        color: linden.colors.accent,
      ),
    );
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: line,
    );
  }
}
