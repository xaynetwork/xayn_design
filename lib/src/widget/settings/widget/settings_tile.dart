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
    return SizedBox(height: linden.dimen.unit5, child: row);
  }

  void _addIcon(Linden linden, List<Widget> rowChildren) {
    final iconPath = data.svgIconPath;
    if (iconPath == null) return;

    final iconSize = linden.dimen.unit3;
    final icon = SvgPicture.asset(
      iconPath,
      color: linden.colors.primary,
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

    final title = Text(data.title, style: linden.styles.appBodyText);

    if (data.subTitle == null) {
      addChild(title);
      return;
    }

    final subTitle = Text(
      data.subTitle!,
      style: linden.styles.appThumbnailTextLight,
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
      case SettingsTileActionText:
        child = _buildActionText(action as SettingsTileActionText);
        break;
      case SettingsTileActionIcon:
        child = _buildActionIcon(action as SettingsTileActionIcon);
        break;
      case SettingsTileActionCircle:
        child = _buildActionCircle(action as SettingsTileActionCircle, linden);
        break;
      case SettingsTileActionSwitch:
        child = _buildActionSwitch(action as SettingsTileActionSwitch);
        break;
      default:
        throw Exception(
            'Unknown instance of $SettingsTileActionText: ${action.runtimeType}');
    }

    final withPadding = Padding(
      padding: EdgeInsets.only(left: linden.dimen.unit2),
      child: Center(child: child),
    );
    rowChildren.add(withPadding);
  }

  Widget _buildActionText(SettingsTileActionText action) =>
      AppRaisedButton.text(
        onPressed: action.onPressed,
        text: action.text,
        key: action.key,
        minSizeEqual: true,
      );

  Widget _buildActionIcon(SettingsTileActionIcon action) =>
      AppRaisedButton.icon(
        key: action.key,
        svgIconPath: action.svgIconPath,
        onPressed: action.onPressed,
      );

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

  Widget _buildActionSwitch(SettingsTileActionSwitch action) => AppSwitchWidget(
        key: action.key,
        value: action.value,
        onToggle: (_) => action.onPressed(),
      );
}
