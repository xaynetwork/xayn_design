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
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = this.config;
    if (config == null || config.type.isHidden) return const Center();

    final items = config.items.map(_buildItem).toList(growable: false);

    if (config.type == NavBarType.backBtn) {
      return _withPadding(_withFixedHeight(Row(children: [items.first])));
    }

    final row = Row(
      mainAxisSize:
          config.isWidthExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: config.isWidthExpanded
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: items,
    );

    // AppCardWidget can't be used becasue it uses Material widget
    // with MaterialType.card, which doesn't allow to customise shadows.
    final card = Container(
      padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit),
      child: row,
      decoration: BoxDecoration(
        color: linden.colors.background,
        borderRadius: BorderRadius.circular(linden.dimen.unit1_5),
        boxShadow: [linden.styles.cardShadow],
      ),
    );

    final sized = _withFixedHeight(card);

    return config.showAboveKeyboard
        // `MediaQuery.of(context).viewInsets.bottom` represents the height of the keyboard
        ? _withPadding(sized, MediaQuery.of(context).viewInsets.bottom)
        : _withPadding(sized);
  }

  Widget _withFixedHeight(Widget card) {
    return SizedBox(
      child: Center(child: card),
      height: linden.dimen.navBarHeight,
    );
  }

  Widget _withPadding(Widget child, [double keyboardHeight = 0]) {
    /// Some devices might have already a bottom padding.
    /// For instance, iPhone 11 has a bottom padding value of 34.0
    final hasDeviceBottomPadding = MediaQuery.of(context).padding.bottom > 0;

    /// If the device already has some bottom padding we should not add
    /// any more to it
    final bottomPadding = hasDeviceBottomPadding
        ? keyboardHeight
        : widget.padding.bottom + keyboardHeight;

    final finalPadding = widget.padding.copyWith(
      bottom: bottomPadding,
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

    final isFirst = config!.items.first == data;
    final isLast = config!.items.last == data;
    final withPadding = Padding(
      padding: EdgeInsets.only(
        left: isFirst ? 0 : linden.dimen.unit0_25,
        right: isLast ? 0 : linden.dimen.unit0_25,
      ),
      child: Center(child: child),
    );

    if (data is NavBarItemEdit) {
      return Expanded(child: withPadding);
    }
    return withPadding;
  }
}
