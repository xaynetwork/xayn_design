import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

typedef _NavBarUpdater = Function(BuildContext context);

class NavBarEdit extends StatefulWidget {
  final NavBarItemEdit data;
  final _NavBarUpdater _updateNavBar;
  final FocusNode? _focusNode;

  const NavBarEdit(
    this.data, {
    @visibleForTesting _NavBarUpdater? updater,
    @visibleForTesting FocusNode? focusNode,
  })  : _updateNavBar = updater ?? NavBarContainer.updateNavBar,
        _focusNode = focusNode,
        super(key: null);

  @override
  State<NavBarEdit> createState() => _NavBarEditState();
}

class _NavBarEditState extends State<NavBarEdit> {
  late final TextEditingController controller;
  late final FocusNode _focusNode;
  bool _didAutoFocus = false;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    _focusNode = widget._focusNode ?? FocusNode();

    controller = TextEditingController(
      text: widget.data.initialText,
    );

    _focusNode.addListener(_onFocusNodeEvent);

    super.initState();
  }

  @override
  void dispose() {
    final wasFocusNodeCreatedLocally = widget._focusNode == null;

    controller.dispose();

    // the listener is always added in this class, so always remove it
    _focusNode.removeListener(_onFocusNodeEvent);

    // dispose when it was created in this Widget's State,
    // otherwise, let the object that passed it in dispose instead...
    if (wasFocusNodeCreatedLocally) _focusNode.dispose();

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

      _focusNode.requestFocus();
    }

    final container = Container(
      height: linden.dimen.navBarSelectableHeight,
      padding: EdgeInsets.symmetric(horizontal: linden.dimen.unit1_5),
      child: row,
      decoration: BoxDecoration(
        color: linden.colors.transparent,
        borderRadius: BorderRadius.circular(linden.dimen.unit),
        border: Border.all(
          width: linden.dimen.inputTextFieldBorderWidth,
          color: linden.colors.inputTextFieldBorderColor,
        ),
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

  void _onFocusNodeEvent() => widget._updateNavBar(context);

  Widget _buildIcon() {
    final icon = SvgPicture.asset(
      widget.data.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.icon,
    );
    return InkWell(
      splashColor: linden.colors.splashColor,
      onTap: _focusNode.requestFocus,
      child: Center(child: icon),
      borderRadius: BorderRadius.circular(linden.dimen.unit),
    );
  }

  /// Use TextFormField because it should resolve: https://github.com/flutter/flutter/issues/98505
  Widget _buildEditText() => TextFormField(
        key: widget.data.key,
        focusNode: _focusNode,
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
