import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsTile extends StatelessWidget {
  final SettingsTileData data;

  const SettingsTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[];

    final linden = UnterDenLinden.getLinden(context);

    _addIcon(linden, rowChildren);
    _addText(linden, rowChildren);
    rowChildren.add(const Spacer());
    _addAction(linden, rowChildren);

    final row = Row(
      children: rowChildren,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    final content = SizedBox(
      height: linden.dimen.unit7,
      child: Padding(
        padding: EdgeInsets.only(
          left: linden.dimen.unit2,
          right: linden.dimen.unit0_5,
        ),
        child: row,
      ),
    );

    final embedInButton =
        data.action?.tapArea == SettingsTileActionTapArea.content;
    return embedInButton
        ? AppGhostButton(
            key: data.action?.key,
            onPressed: data.action?.onPressed,
            contentPadding: EdgeInsets.zero,
            child: content,
          )
        : content;
  }

  void _addIcon(Linden linden, List<Widget> rowChildren) {
    final iconPath = data.svgIconPath;
    if (iconPath == null) return;

    final iconSize = linden.dimen.unit3;
    final icon = SvgPicture.asset(
      iconPath,
      color: linden.colors.icon,
      width: iconSize,
      height: iconSize,
    );

    final withPadding = Padding(
      padding: EdgeInsets.only(right: linden.dimen.unit2),
      child: icon,
    );
    rowChildren.add(Center(child: withPadding));
  }

  void _addText(
    Linden linden,
    List<Widget> rowChildren,
  ) {
    void addChild(Widget child) => rowChildren.add(Center(child: child));

    final title = Text(
      data.title,
      style: linden.styles.newSettingsSectionText,
    );

    // ignore: deprecated_member_use_from_same_package
    if (data.subTitle == null) {
      addChild(title);
      return;
    }

    final subTitle = Text(
      // ignore: deprecated_member_use_from_same_package
      data.subTitle!,
      style: linden.styles.sStyle.copyWith(
        color: linden.colors.secondaryText,
      ),
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(height: linden.dimen.unit0_5),
        subTitle,
      ],
    );
    addChild(column);
  }

  void _addAction(Linden linden, List<Widget> rowChildren) {
    final action = data.action;
    if (action == null) return;
    late final Widget child;
    switch (action.runtimeType) {
      // ignore: deprecated_member_use_from_same_package
      case SettingsTileActionText:
        // ignore: deprecated_member_use_from_same_package
        child = _buildActionText(action as SettingsTileActionText);
        break;
      case SettingsTileActionIcon:
        child = _buildActionIcon(action as SettingsTileActionIcon, linden);
        break;
      // ignore: deprecated_member_use_from_same_package
      case SettingsTileActionCircle:
        // ignore: deprecated_member_use_from_same_package
        child = _buildActionCircle(action as SettingsTileActionCircle, linden);
        break;
      // ignore: deprecated_member_use_from_same_package
      case SettingsTileActionSwitch:
        // ignore: deprecated_member_use_from_same_package
        child = _buildActionSwitch(action as SettingsTileActionSwitch);
        break;
      default:
        throw Exception(
            'Unknown instance of $SettingsTileAction: ${action.runtimeType}');
    }

    final withPadding = Padding(
      padding: EdgeInsets.only(left: linden.dimen.unit2),
      child: Center(child: child),
    );
    rowChildren.add(withPadding);
  }

  // ignore: deprecated_member_use_from_same_package
  Widget _buildActionText(SettingsTileActionText action) =>
      AppRaisedButton.text(
        onPressed: action.onPressed,
        text: action.text,
        key: action.key,
        minSizeEqual: true,
      );

  Widget _buildActionIcon(SettingsTileActionIcon action, Linden linden) =>
      SizedBox(
        width: linden.dimen.iconButtonSize,
        height: linden.dimen.iconButtonSize,
        child: SvgPicture.asset(
          action.svgIconPath,
          fit: BoxFit.none,
          width: linden.dimen.iconSize,
          height: linden.dimen.iconSize,
          color: linden.colors.icon,
        ),
      );

  // ignore: deprecated_member_use_from_same_package
  Widget _buildActionCircle(SettingsTileActionCircle action, Linden linden) {
    final btn = AppRaisedButton.icon(
      key: action.key,
      svgIconPath: action.svgIconPath,
      onPressed: action.onPressed,
      contentPadding: EdgeInsets.all(linden.dimen.unit0_5),
      color: action.isActive ? ButtonColor.primary : ButtonColor.tertiary,
      circle: true,
    );
    return SizedBox(
      height: linden.dimen.unit3,
      child: Center(child: btn),
    );
  }

  // ignore: deprecated_member_use_from_same_package
  Widget _buildActionSwitch(SettingsTileActionSwitch action) => AppSwitchWidget(
        key: action.key,
        value: action.value,
        onToggle: (_) => action.onPressed(),
      );
}
