import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/settings/widget/settings_background.dart';
import 'package:xayn_design/xayn_design.dart';

enum SettingsSelectableType {
  icon,
  graphic,
}

class SettingsSelectable extends StatelessWidget {
  final List<SettingsSelectableData> items;
  final SettingsSelectableType type;

  const SettingsSelectable.icons({
    Key? key,
    required this.items,
  })  : type = SettingsSelectableType.icon,
        super(key: key);

  @Deprecated('Old Style Settings, might be removed')
  const SettingsSelectable.graphics({
    Key? key,
    required this.items,
  })  : type = SettingsSelectableType.graphic,
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      SettingsBackground(child: LayoutBuilder(builder: _buildGroup));

  Widget _buildGroup(BuildContext context, BoxConstraints constraints) {
    final itemConstrains =
        BoxConstraints(minWidth: constraints.maxWidth / items.length);

    switch (type) {
      case SettingsSelectableType.icon:
        return SettingsSelectableIconGroup(
          constraints: itemConstrains,
          items: items,
        );
      case SettingsSelectableType.graphic:
        return SettingsSelectableGraphicGroup(
          items: items,
          constraints: itemConstrains,
        );
    }
  }
}

class SettingsSelectableIconGroup extends StatelessWidget {
  final BoxConstraints constraints;
  final List<SettingsSelectableData> items;

  const SettingsSelectableIconGroup({
    Key? key,
    required this.constraints,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    return SettingsBackground(
      child: ToggleButtons(
          fillColor: linden.colors.primary,
          splashColor: linden.colors.splashColor,
          renderBorder: false,
          constraints: constraints,
          isSelected: items.map((e) => e.isSelected).toList(),
          children: items.map((e) => SettingsSelectableIcon(item: e)).toList(),
          onPressed: (int index) {
            items[index].onPressed();
          }),
    );
  }
}

class SettingsSelectableIcon extends StatelessWidget {
  final SettingsSelectableData item;

  const SettingsSelectableIcon({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final icon = SvgPicture.asset(
      item.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: linden.colors.settingsIcon,
    );

    final withCircle = Container(
      child: Center(child: icon),
      decoration: BoxDecoration(
        color: linden.colors.iconBackground,
        shape: BoxShape.circle,
      ),
      width: linden.dimen.unit5,
      height: linden.dimen.unit5,
    );

    final title = Text(
      item.title,
      textAlign: TextAlign.center,
      style: linden.styles.sBoldStyle.copyWith(
        color: item.isSelected
            ? linden.colors.primaryTextInverse
            : linden.colors.secondaryText,
      ),
    );

    final column = Column(
      children: [
        withCircle,
        SizedBox(height: linden.dimen.unit1_5),
        title,
      ],
      mainAxisSize: MainAxisSize.min,
    );
    return Padding(
      key: item.key,
      padding: EdgeInsets.symmetric(vertical: linden.dimen.unit2),
      child: column,
    );
  }
}

class SettingsSelectableGraphicGroup extends StatelessWidget {
  final BoxConstraints constraints;
  final List<SettingsSelectableData> items;

  const SettingsSelectableGraphicGroup({
    Key? key,
    required this.constraints,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = items
        .map(
            (e) => SettingsSelectableGraphic(item: e, constraints: constraints))
        .toList();
    return Row(children: children);
  }
}

class SettingsSelectableGraphic extends StatelessWidget {
  final BoxConstraints constraints;
  final SettingsSelectableData item;

  const SettingsSelectableGraphic({
    Key? key,
    required this.item,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final radioBtn = Radio<SettingsSelectableData>(
      key: item.key,
      value: item,
      groupValue: item.isSelected ? item : null,
      onChanged: (_) => item.onPressed(),
      activeColor: linden.colors.accent,
    );
    final graphic = Container(
      constraints: BoxConstraints(
        maxHeight: linden.dimen.graphicsHeight,
        maxWidth: linden.dimen.graphicsGridViewWidth,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: item.isSelected
            ? linden.colors.iconSelected
            : linden.colors.iconDisabled,
        borderRadius: linden.styles.roundBorder0_5,
      ),
      child: SvgPicture.asset(item.svgIconPath),
    );

    final title = Text(
      item.title,
      textAlign: TextAlign.center,
      style: linden.styles.sBoldStyle,
    );
    final children = <Widget>[
      radioBtn,
      graphic,
      SizedBox(height: linden.dimen.unit1_5),
      title,
      SizedBox(height: linden.dimen.unit2),
    ];

    return InkWell(
      key: item.key,
      onTap: item.onPressed,
      child: Container(
        constraints: constraints,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
