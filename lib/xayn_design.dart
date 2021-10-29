/// Flutter widgets and design objects for Xayn Design library
/// exposing [Linden] design object.
///
/// To use, import `package:xayn_design/xayn_design.dart`.
library xayn_design;

export 'src/linden/linden.dart' show Linden;

export 'src/linden/xanimations.dart' show XAnimations;
export 'src/linden/xassets.dart' show XAssets;
export 'src/linden/xsizes.dart' show XSizes, Experiences;
export 'src/linden/xcolors.dart' show XColors;
export 'src/linden/xstyles.dart' show XStyles;
export 'src/utils/safe_platform.dart' show SafePlatform;

export 'src/widget/build_observer.dart';
export 'src/widget/tooltip/messages/textual_notification.dart';
export 'src/widget/tooltip/messages/tooltip_message.dart';
export 'src/widget/tooltip/messages/tooltip_message_key.dart';
export 'src/widget/tooltip/application_tooltip_provider.dart';
export 'src/widget/tooltip/tooltip.dart';
export 'src/widget/tooltip/tooltip_context_provider_state_mixin.dart';
export 'src/widget/tooltip/tooltip_controller.dart';
export 'src/widget/tooltip/tooltip_options.dart';
export 'src/widget/tooltip/tooltip_state_mixin.dart';
export 'src/widget/tooltip/tooltip_stateless_mixin.dart';

export 'package:flutter_svg/flutter_svg.dart';
