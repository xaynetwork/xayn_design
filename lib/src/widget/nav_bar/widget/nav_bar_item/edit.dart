import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/nav_bar/data/nav_bar_item.dart';
import 'package:xayn_design/xayn_design.dart';

class NavBarEdit extends StatefulWidget {
  final NavBarItemEdit data;

  const NavBarEdit(this.data) : super(key: null);

  @override
  State<NavBarEdit> createState() => _NavBarEditState();
}

class _NavBarEditState extends State<NavBarEdit> {
  final focusNode = FocusNode();

  late final TextEditingController controller;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    controller = TextEditingController(text: widget.data.initialText);
    if (widget.data.autofocus) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        focusNode.requestFocus();
      });
    }

    focusNode.addListener(() {
      NavBarContainer.updateNavBar(context);
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
    final icon = SvgPicture.asset(
      widget.data.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.iconNew,
    );

    final row = Row(
      children: [
        icon,
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

  Widget _buildEditText() => TextField(
        key: widget.data.key,
        focusNode: focusNode,
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
