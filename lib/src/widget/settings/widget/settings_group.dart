import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsGroupWidget extends StatelessWidget {
  final SettingsGroupData data;

  const SettingsGroupWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);
    final children = <Widget>[];

    _addTitle(context, children, linden);

    final size = data.items.length;
    for (int i = 0; i < size; i++) {
      children.add(SettingsTileWidget(data: data.items[i]));
      if (i < size - 1) {
        // we want to add widget after every item except the last one
        children.add(SizedBox(height: linden.dimen.unit2));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  void _addTitle(
    BuildContext context,
    List<Widget> children,
    Linden linden,
  ) {
    final title = data.title;
    if (title == null) return;

    final padding = Padding(
      padding: EdgeInsets.symmetric(vertical: linden.dimen.unit),
      child: Text(title, style: linden.styles.settingsLayoutSectionText),
    );
    children.add(padding);
  }
}
