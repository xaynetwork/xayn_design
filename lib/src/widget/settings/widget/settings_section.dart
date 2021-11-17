import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<SettingsCardData> items;
  final Widget? _child;

  const SettingsSectionWidget({
    Key? key,
    required this.title,
    required this.items,
    this.subTitle,
  })  : assert(items.length > 0),
        _child = null,
        super(key: key);

  SettingsSectionWidget.fromTile({
    Key? key,
    required this.title,
    required SettingsTileData tileData,
    this.subTitle,
  })  : items = [
          SettingsCardData([
            SettingsGroupData(items: [tileData])
          ])
        ],
        _child = null,
        super(key: key);

  /// So far used to show [SettingsSelectableWidget]
  SettingsSectionWidget.custom({
    Key? key,
    required this.title,
    required Widget child,
    this.subTitle,
  })  : items = [const SettingsCardData([])],
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final columnChildren = <Widget>[
      SizedBox(height: linden.dimen.unit4),
      _buildTitle(linden),
    ];

    final subTitle = _buildSubTitle(linden);
    if (subTitle != null) {
      columnChildren
        ..add(SizedBox(height: linden.dimen.unit))
        ..add(subTitle);
    }

    columnChildren.add(SizedBox(height: linden.dimen.unit2));

    if (_child != null) {
      columnChildren.add(_child!);
    } else {
      final size = items.length;
      for (int i = 0; i < size; i++) {
        final card = SettingsCardWidget(data: SettingsCardData(items[i].items));
        columnChildren.add(card);
        if (i < size - 1) {
          // we want to add widget after every item except the last one
          columnChildren.add(SizedBox(height: linden.dimen.unit));
        }
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren,
    );
  }

  Widget _buildTitle(Linden linden) => Text(
        title,
        style: linden.styles.appHeadlineText,
      );

  Widget? _buildSubTitle(Linden linden) => subTitle == null
      ? null
      : Text(
          subTitle!,
          style: linden.styles.appBodyText,
        );
}
