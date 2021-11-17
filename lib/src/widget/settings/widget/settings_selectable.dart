import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

enum SettingsSelectable {
  icon,
  graphic,
}

class SettingsSelectableWidget extends StatelessWidget {
  final List<SettingsSelectableItem> items;
  final SettingsSelectable type;

  const SettingsSelectableWidget.icons({
    Key? key,
    required this.items,
  })  : type = SettingsSelectable.icon,
        super(key: key);

  const SettingsSelectableWidget.graphics({
    Key? key,
    required this.items,
  })  : type = SettingsSelectable.graphic,
        super(key: key);

  @override
  Widget build(BuildContext context) => AppCardWidget(
        child: LayoutBuilder(builder: _buildGroup),
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildGroup(BuildContext context, BoxConstraints constraints) {
    final linden = UnterDenLinden.getLinden(context);

    final itemConstrains =
        BoxConstraints(minWidth: constraints.maxWidth / items.length);

    switch (type) {
      case SettingsSelectable.icon:
        return _buildIconGroup(itemConstrains, linden);
      case SettingsSelectable.graphic:
        return _buildGraphicGroup(itemConstrains, linden);
    }
  }

  Widget _buildIconGroup(BoxConstraints itemConstraints, Linden linden) =>
      ToggleButtons(
        fillColor: linden.colors.accent,
        renderBorder: false,
        constraints: itemConstraints,
        isSelected: items.map((e) => e.isSelected).toList(),
        children: items.map((e) => _buildIconItem(e, linden)).toList(),
        onPressed: (int index) {
          items[index].onPressed();
        },
      );

  Widget _buildGraphicGroup(BoxConstraints itemConstraints, Linden linden) {
    final children = items
        .map((e) => _buildGraphicIcon(e, itemConstraints, linden))
        .toList();
    return Row(
      children: children,
    );
  }

  Widget _buildGraphicIcon(
    SettingsSelectableItem item,
    BoxConstraints itemConstraints,
    Linden linden,
  ) {
    final radioBtn = Radio<SettingsSelectableItem>(
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
      style: linden.styles.settingsLayoutSectionText,
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
        constraints: itemConstraints,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }

  Widget _buildIconItem(SettingsSelectableItem item, Linden linden) {
    final icon = SvgPicture.asset(
      item.svgIconPath,
      width: linden.dimen.iconSize,
      height: linden.dimen.iconSize,
      color: item.isSelected ? linden.colors.accent : linden.colors.primary,
    );

    final withCircle = Container(
      child: Center(child: icon),
      decoration: BoxDecoration(
        color: item.isSelected
            ? linden.colors.iconBackgroundSelected
            : linden.colors.iconBackground,
        shape: BoxShape.circle,
      ),
      width: linden.dimen.unit5,
      height: linden.dimen.unit5,
    );

    final isDarkMode = linden.brightness == Brightness.dark;
    final title = Text(
      item.title,
      textAlign: TextAlign.center,
      style: item.isSelected && !isDarkMode
          ? linden.styles.settingsLayoutSectionTextSelected
          : linden.styles.settingsLayoutSectionText,
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
      padding: EdgeInsets.symmetric(vertical: linden.dimen.unit2),
      child: column,
    );
  }
}
