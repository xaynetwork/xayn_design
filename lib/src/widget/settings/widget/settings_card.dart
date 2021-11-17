import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsCardWidget extends StatelessWidget {
  final SettingsCardData data;

  const SettingsCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final children = <Widget>[];

    final size = data.items.length;
    for (int i = 0; i < size; i++) {
      children.add(SettingsGroupWidget(data: data.items[i]));
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

    final contentPadding = EdgeInsets.fromLTRB(
      linden.dimen.unit2,
      linden.dimen.unit,
      linden.dimen.unit,
      linden.dimen.unit,
    );

    return AppCardWidget(
      elevation: linden.dimen.elevationHigh,
      child: column,
      contentPadding: contentPadding,
    );
  }
}
