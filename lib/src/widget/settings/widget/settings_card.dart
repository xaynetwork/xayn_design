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
    final size = data.items.length;
    final children = List.generate(
      size,
      (i) => [
        SettingsGroup(data: data.items[i]),
        if (i < size - 1) const Divider(),
      ],
    ).expand((it) => it).toList(growable: false);

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );

    return SettingsBackground(child: column);
  }
}
