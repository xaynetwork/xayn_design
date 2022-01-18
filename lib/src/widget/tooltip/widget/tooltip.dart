import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xayn_design/src/widget/unter_den_linden/unter_den_linden_mixin.dart';
import 'package:xayn_design/xayn_design.dart';

const Duration kFadeInDuration = Duration(milliseconds: 150);
const Duration kFadeOutDuration = Duration(milliseconds: 75);

typedef ContextProvider = BuildContext? Function();

typedef MessageFactory = Map<TooltipKey, TooltipParams>;
typedef OnController = void Function(TooltipController);
typedef ShowTooltipWhen = bool Function();

enum TooltipStyle {
  normal,
  arrow,
}

class Tooltip extends StatefulWidget {
  final TooltipController? controller;
  final ContextProvider? contextProvider;
  final MessageFactory messageFactory;
  final double? height;
  final double? verticalOffset;
  final Widget? child;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final bool preferBelow;
  final ShowTooltipWhen? showTooltipWhen;

  /// Creates a [Tooltip] which uses the dimensions of its own [BuildContext]
  /// for rendering.
  const Tooltip({
    Key? key,
    required this.messageFactory,
    this.height,
    this.verticalOffset,
    this.child,
    this.controller,
    this.fadeInDuration = kFadeInDuration,
    this.fadeOutDuration = kFadeOutDuration,
    this.preferBelow = true,
    this.showTooltipWhen,
  })  : contextProvider = null,
        super(key: key);

  /// Creates a [Tooltip], which targets a dynamic [BuildContext] as a render
  /// target.
  Tooltip.contextDeferred({
    Key? key,
    required this.messageFactory,
    this.contextProvider,
    this.height,
    this.verticalOffset,
    this.child,
    this.fadeInDuration = kFadeInDuration,
    this.fadeOutDuration = kFadeOutDuration,
    this.preferBelow = false,
    this.showTooltipWhen,
  })  : controller = TooltipController(),
        super(key: key);

  @override
  _TooltipState createState() => _TooltipState();
}

class _OverlayKeyEntry {
  final TooltipKey key;
  final OverlayEntry entry;

  const _OverlayKeyEntry({required this.key, required this.entry});

  void remove() => entry.remove();
}

class _TooltipOverlay extends StatelessWidget {
  final MessageFactory messageFactory;
  final Linden linden;
  final TooltipKey tooltipKey;
  final double height;
  final Animation<double> animation;
  final Offset offset;
  final double verticalOffset;
  final bool preferBelow;

  const _TooltipOverlay({
    Key? key,
    required this.messageFactory,
    required this.linden,
    required this.tooltipKey,
    required this.height,
    required this.animation,
    required this.offset,
    required this.verticalOffset,
    required this.preferBelow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!messageFactory.containsKey(tooltipKey)) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$tooltipKey has no matching builder.'),
        ErrorDescription(
          'The messageFactory of this Tooltip Widget is missing a requested Key '
          'Could not detect a Key of value $tooltipKey in the messageFactory. Did you forget to add an entry?\n\nThese keys exist:\n\n${messageFactory.keys.map((it) => it.value).join('\n')}',
        ),
      ]);
    }

    final params = messageFactory[tooltipKey]!;

    return Positioned.fill(
      child: CustomSingleChildLayout(
        delegate: _TooltipPositionDelegate(
          linden: linden,
          target: offset,
          verticalOffset: verticalOffset,
          preferBelow: preferBelow,
        ),
        child: FadeTransition(
          opacity: animation,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Center(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: params.builder(context),
            ),
          ),
        ),
      ),
    );
  }
}

/// A delegate for computing the layout of a tooltip to be displayed above or
/// bellow a target specified in the global coordinate system.
class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  /// The offset of the target the tooltip is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// tooltip.
  final double verticalOffset;

  /// Whether the tooltip is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  final Linden linden;

  /// Creates a delegate for computing the layout of a tooltip.
  ///
  /// The arguments must not be null.
  _TooltipPositionDelegate({
    required this.linden,
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final box = positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );

    final additionalOffset = preferBelow ? .0 : -linden.dimen.unit2;
    final normalizedOffset =
        min(box.dy, size.height - childSize.height) + additionalOffset;
    final dx = preferBelow ? box.dx : size.width / 2 - childSize.width / 2;

    return Offset(dx, normalizedOffset);
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

class _TooltipState extends State<Tooltip>
    with SingleTickerProviderStateMixin, UnterDenLindenMixin {
  late double height;
  late AnimationController animationController;
  late final TooltipController tooltipController;
  _OverlayKeyEntry? overlayKey;
  bool didDispose = false;

  @override
  Widget build(BuildContext context) {
    assert(Overlay.of(context, debugRequiredFor: widget) != null);

    height = widget.height ?? _getDefaultTooltipHeight();

    return ChangeNotifierProvider<TooltipController>.value(
      value: tooltipController,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    didDispose = true;

    if (animationController.status == AnimationStatus.dismissed) {
      // ok to dismiss now
      _disposeAfterTimeToLive();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _initController();

    animationController = AnimationController(
      duration: widget.fadeInDuration,
      reverseDuration: widget.fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
  }

  void _createNewEntry() {
    final tooltipKey = tooltipController.activeKey!;
    final overlayState = Overlay.of(context, debugRequiredFor: widget)!;
    final contextProvider = widget.contextProvider ?? () => context;
    final targetContext = contextProvider() ?? context;
    final box = targetContext.findRenderObject()! as RenderBox;
    final messageFactory = Map.of(widget.messageFactory)
      ..addAll(tooltipController.customFactory);
    //ignore: prefer_function_declarations_over_variables
    final calculateCurrentOffset = () => box.localToGlobal(
          targetContext.size!.center(Offset.zero),
          ancestor: overlayState.context.findRenderObject(),
        );

    final linden = this.linden;
    final defaultStyleOffset =
        tooltipController.activeStyle == TooltipStyle.normal
            ? linden.dimen.unit4
            : linden.dimen.unit2_5;
    final verticalOffset = widget.verticalOffset ?? defaultStyleOffset;
    // We create this widget outside of the overlay entry's builder to prevent
    // updated values from happening to leak into the overlay when the overlay
    // rebuilds.
    final Widget overlay = Directionality(
      textDirection: Directionality.of(context),
      child: BuildObserver(
        owner: targetContext.owner!,
        onBuild: calculateCurrentOffset,
        initialValue: calculateCurrentOffset(),
        builder: (context, Offset? offset) => _TooltipOverlay(
          linden: linden,
          messageFactory: messageFactory,
          tooltipKey: tooltipKey,
          height: height,
          animation: CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn,
          ),
          offset: offset ?? const Offset(.0, .0),
          verticalOffset: verticalOffset,
          preferBelow: widget.preferBelow,
        ),
      ),
    );

    overlayKey = _OverlayKeyEntry(
      key: tooltipController.activeKey!,
      entry: OverlayEntry(
        builder: (context) => ChangeNotifierProvider.value(
          value: tooltipController,
          child: overlay,
        ),
      ),
    );

    overlayState.insert(overlayKey!.entry);
  }

  /// Should [dispose] be called, while the tooltip message in the [Overlay] still
  /// needs time to live, then await that time, and dispose related instances
  /// after that interval only.
  void _disposeAfterTimeToLive() {
    tooltipController.removeListener(_onTooltipControllerNotification);

    animationController.dispose();
    tooltipController.dispose();
  }

  double _getDefaultTooltipHeight() {
    final theme = Theme.of(context);

    switch (theme.platform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return linden.dimen.unit3;
      default:
        return linden.dimen.unit4;
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _hideTooltip(immediately: true);

      if (didDispose) {
        _disposeAfterTimeToLive();
      }
    }
  }

  void _hideTooltip({bool immediately = false}) {
    if (immediately || didDispose) {
      _removeEntry();

      return;
    }

    animationController
        .reverse()
        // because the parent widget may be "hidden", the animation controller cannot progress with ticks,
        // should this be the case, then add a timeout, after which the OverlayEntry is ultimately disposed.
        .timeout(widget.fadeOutDuration, onTimeout: _removeEntry);
  }

  void _initController() {
    tooltipController = widget.controller ?? TooltipController();

    widget.messageFactory.forEach(
        (key, params) => tooltipController.register(key: key, params: params));

    tooltipController.addListener(_onTooltipControllerNotification);
  }

  void _onTooltipControllerNotification() {
    final checkCondition = widget.showTooltipWhen ?? () => true;

    if (tooltipController.activeKey != null && checkCondition()) {
      _showTooltip();
    } else {
      _hideTooltip(immediately: false);
    }
  }

  void _removeEntry() {
    overlayKey?.remove();
    overlayKey = null;
  }

  bool _showTooltip() {
    if (overlayKey != null) {
      if (overlayKey!.key == tooltipController.activeKey) {
        animationController.forward();

        return false; // Already visible.
      } else {
        _hideTooltip(immediately: true);
      }
    }

    _createNewEntry();

    animationController.forward();

    return true;
  }
}
