import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';
import 'package:xayn_design/xayn_design.dart';

typedef _NavBarUpdater = Function(BuildContext context);

class NavBarEdit extends StatefulWidget {
  final NavBarItemEdit data;
  final _NavBarUpdater _updateNavBar;
  final FocusNode _focusNode;

  NavBarEdit(
    this.data, {
    @visibleForTesting _NavBarUpdater? updater,
    @visibleForTesting FocusNode? focusNode,
  })  : _updateNavBar = updater ?? NavBarContainer.updateNavBar,
        _focusNode = focusNode ?? FocusNode(),
        super(key: null);

  @override
  State<NavBarEdit> createState() => _NavBarEditState();
}

class _NavBarEditState extends State<NavBarEdit> {
  late final TextEditingController controller;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    controller = TextEditingController(text: widget.data.initialText);
    if (widget.data.autofocus) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        widget._focusNode.requestFocus();
      });
    }

    widget._focusNode.addListener(() {
      widget._updateNavBar(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        _buildIcon(),
        SizedBox(width: linden.dimen.unit),
        Expanded(child: _buildEditText()),
      ],
    );
    // return row;

    final container = Container(
      height: linden.dimen.navBarSelectableHeight,
      padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit1_5),
      child: row,
      decoration: BoxDecoration(
        color: linden.colors.searchInputFill,
        borderRadius: BorderRadius.circular(linden.dimen.unit),
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit0_25),
      child: container,
    );
  }

  Widget _buildIcon() {
    final icon = SvgPicture.asset(
      widget.data.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.iconNew,
    );
    return InkWell(
      onTap: widget._focusNode.requestFocus,
      child: Center(child: icon),
      borderRadius: BorderRadius.circular(linden.dimen.unit),
    );
  }

  Widget _buildEditText() => TextField(
        key: widget.data.key,
        focusNode: widget._focusNode,
        controller: controller,
        style: linden.styles.textInputTextSmall,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        onChanged: widget.data.onTextChanged,
        onSubmitted: widget.data.onSearchPressed,
        decoration: InputDecoration.collapsed(
          hintText: widget.data.hint,
          hintStyle: linden.styles.textInputHintSmall,
        ),
      );
}
