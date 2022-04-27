import 'package:flutter/cupertino.dart';
import 'package:xayn_design/xayn_design.dart';

class TooltipMessages {
  TooltipMessages._();

  static simple() => TooltipData.textual(
        key: 'simple',
        label: 'This is simple tooltip',
      );

  static withIcon(BuildContext context) => TooltipData.customized(
        key: 'withIcon',
        label: 'Undo Action',
        icon: UnterDenLinden.getLinden(context).assets.icons.info,
      );

  static longText(BuildContext context) => TooltipData.customized(
        key: 'longText',
        label:
            'Hi there! This is a tooltip message with the extremely very long-long long text',
        icon: UnterDenLinden.getLinden(context).assets.icons.info,
      );

  static twoLines() => TooltipData.textual(
        key: 'twoLines',
        label: 'This is tooltip message\nwith 2 lines',
      );
}
