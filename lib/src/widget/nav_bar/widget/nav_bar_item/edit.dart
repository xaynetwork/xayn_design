import 'package:flutter/material.dart';
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
  bool _didAutoFocus = false;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.data.initialText,
    );

    widget._focusNode.addListener(() {
      widget._updateNavBar(context);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    widget._focusNode.dispose();
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

    if (!_didAutoFocus && widget.data.autofocus) {
      _didAutoFocus = true;

      widget._focusNode.requestFocus();
    }

    final container = Container(
      height: linden.dimen.navBarSelectableHeight,
      padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit1_5),
      child: row,
      decoration: BoxDecoration(
        color: linden.colors.searchInputFill,
        borderRadius: BorderRadius.circular(linden.dimen.unit),
      ),
    );
    return Material(
      color: linden.colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit0_25),
        child: container,
      ),
    );
  }

  Widget _buildIcon() {
    final icon = SvgPicture.asset(
      widget.data.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.icon,
    );
    return InkWell(
      splashColor: linden.colors.splashColor,
      onTap: widget._focusNode.requestFocus,
      child: Center(child: icon),
      borderRadius: BorderRadius.circular(linden.dimen.unit),
    );
  }

  /// Use TextFormField because it should resolve: https://github.com/flutter/flutter/issues/98505
  Widget _buildEditText() => TextFormField(
        key: widget.data.key,
        focusNode: widget._focusNode,
        controller: controller,
        style: linden.styles.textInputText,
        textInputAction: TextInputAction.search,
        keyboardAppearance: linden.colors.brightness,
        maxLines: 1,
        onChanged: widget.data.onTextChanged,
        onFieldSubmitted: widget.data.onSearchPressed,
        decoration: InputDecoration.collapsed(
          hintText: widget.data.hint,
          hintStyle: linden.styles.textInputHint,
        ),
      );
}
