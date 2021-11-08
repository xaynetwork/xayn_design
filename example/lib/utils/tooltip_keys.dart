import 'package:xayn_design/xayn_design.dart';

class TooltipKeys {
  TooltipKeys._();

  static const simple = TooltipKey('simple');
  static const withIcon = TooltipKey('with_icon');
}

abstract class TooltipMessageProvider {
  TooltipMessageProvider._();

  static MessageFactory of() => {
        TooltipKeys.simple: TooltipParams(
          label: 'This is simple tooltip',
          builder: (_) => const TextualNotification(),
        ),
      };
}
