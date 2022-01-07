import 'package:flutter/material.dart';
import 'package:xayn_design/src/widget/settings/widget/settings_background.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsCard extends StatelessWidget {
  final SettingsCardData data;

  const SettingsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    final size = data.items.length;
    for (int i = 0; i < size; i++) {
      children.add(SettingsGroup(data: data.items[i]));
      if (i < size - 1) {
        // we want to add widget after every item except the last one
        children.add(const Divider());
      }
    }

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );

    return SettingsBackground(child: column);
  }
}
