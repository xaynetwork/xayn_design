import 'package:flutter/material.dart';
import 'package:xayn_design/src/linden/linden.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden.dart';

const _kDividerThickness = 1.0;

class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
    required this.children,
    this.errorStr,
    this.physics = const NeverScrollableScrollPhysics(),
    this.onClose,
    this.isSticky = false,
    this.permitRoutePop = true,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.width,
    this.height,
    this.textDirection = TextDirection.ltr,
  })  : assert(
          start == null || end == null || width == null,
          'AppMenu needs to have horizontal constraints: start or end or width',
        ),
        assert(
          top == null || bottom == null || height == null,
          'AppMenu needs to have vertical constraints: top or bottom or height',
        ),
        super(key: key);

  final List<Widget> children;
  final String? errorStr;
  final ScrollPhysics? physics;
  final VoidCallback? onClose;

  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final double? width;
  final double? height;
  final TextDirection textDirection;

  /// when true, the menu doesn't close when user clicks outside
  final bool isSticky;

  /// when true, native navigation pop calls are not blocked after closing the menu
  final bool permitRoutePop;

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final childrenSeparatedList = ListView.separated(
      physics: physics,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: linden.dimen.unit3),
      itemBuilder: (_, i) => children.elementAt(i),
      separatorBuilder: (_, __) => _buildDivider(linden),
      itemCount: children.length,
    );

    final menu = Material(
      elevation: linden.dimen.unit5,
      shadowColor: linden.colors.shadowTransparent,
      borderRadius: linden.styles.roundBorder,
      clipBehavior: Clip.antiAlias,
      color: linden.colors.background,
      child: errorStr == null
          ? childrenSeparatedList
          : _buildWithError(
              childrenSeparatedList,
              errorStr!,
              linden,
            ),
    );

    final positionedMenu = Positioned.directional(
      child: menu,
      textDirection: textDirection,
      start: start,
      top: top,
      end: end,
      bottom: bottom,
      width: width,
      height: height,
    );

    if (onClose == null) return positionedMenu;

    final dismissibleMenu = Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
          ),
        ),
        positionedMenu,
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        onClose!();
        return permitRoutePop;
      },
      child: isSticky ? positionedMenu : dismissibleMenu,
    );
  }

  Widget _buildDivider(Linden linden) => Divider(
        color: linden.colors.menuDividerColor,
        height: linden.dimen.unit4,
        thickness: _kDividerThickness,
      );

  Widget _buildWithError(Widget child, String errorString, Linden linden) {
    final errorText = Center(
      child: Text(
        errorString,
        style: linden.styles.readerModeSettingsErrorTextStyle,
        maxLines: 2,
      ),
    );

    final errorWidget = ColoredBox(
      color: linden.colors.readerModeSettingsErrorBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: linden.dimen.unit,
          horizontal: linden.dimen.unit2,
        ),
        child: errorText,
      ),
    );

    final errorClipRect = ClipRRect(
      borderRadius: linden.styles.readerModeSettingsErrorBorder,
      child: errorWidget,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        errorClipRect,
        child,
      ],
    );
  }
}
