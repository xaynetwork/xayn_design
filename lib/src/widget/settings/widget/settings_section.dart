import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

const _defaultAlignment = CrossAxisAlignment.start;

/// Should be equal to [XSizes.unit4];
const _defaultTopPadding = 32.0;

class SettingsSection extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<SettingsCardData> items;
  final Widget? _child;

  /// Padding, that applied above title.
  /// if value not provided via constructor, the default applied.
  /// Should be >= 0
  final double topPadding;

  /// Controls how the children should be placed along the cross axis
  final CrossAxisAlignment crossAxisAlignment;

  const SettingsSection({
    Key? key,
    required this.title,
    required this.items,
    this.subTitle,
    this.crossAxisAlignment = _defaultAlignment,
    this.topPadding = _defaultTopPadding,
  })  : assert(items.length > 0),
        assert(topPadding >= 0),
        _child = null,
        super(key: key);

  SettingsSection.fromTile({
    Key? key,
    required this.title,
    required SettingsTileData tileData,
    this.subTitle,
    this.crossAxisAlignment = _defaultAlignment,
    this.topPadding = _defaultTopPadding,
  })  : assert(topPadding >= 0),
        items = [
          SettingsCardData([
            SettingsGroupData(items: [tileData])
          ])
        ],
        _child = null,
        super(key: key);

  /// So far used to show [SettingsSelectable]
  SettingsSection.custom({
    Key? key,
    required this.title,
    required Widget child,
    this.subTitle,
    this.crossAxisAlignment = _defaultAlignment,
    this.topPadding = _defaultTopPadding,
  })  : assert(topPadding >= 0),
        items = [],
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final linden = UnterDenLinden.getLinden(context);

    final columnChildren = <Widget>[
      SizedBox(height: topPadding),
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
        final card = SettingsCard(data: SettingsCardData(items[i].items));
        columnChildren.add(card);
        if (i < size - 1) {
          // we want to add widget after every item except the last one
          columnChildren.add(SizedBox(height: linden.dimen.unit));
        }
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
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
