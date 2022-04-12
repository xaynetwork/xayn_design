import 'package:xayn_design/xayn_design.dart';

class TooltipKeys {
  TooltipKeys._();

  static const simple = TooltipKey('simple');
  static const withIcon = TooltipKey('with_icon');
  static const twoLines = TooltipKey('two_lines');
  static const longText = TooltipKey('long_text');
}

abstract class TooltipMessageProvider {
  TooltipMessageProvider._();

  static MessageFactory of() => {
        TooltipKeys.simple: TooltipParams(
          label: 'This is simple tooltip',
          builder: (_) => const TextualNotification(),
        ),
        TooltipKeys.longText: TooltipParams(
          label: 'Hi there! This is a tooltip message with the extremely very long-long long text',
          builder: (_) => CustomizedTextualNotification(
            icon: UnterDenLinden.getLinden(_).assets.icons.info,
          ),
        ),
        TooltipKeys.twoLines: TooltipParams(
          label: 'This is tooltip message\nwith 2 lines',
          builder: (_) => const TextualNotification(),
        ),
      };
}
