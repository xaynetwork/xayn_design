import 'package:flutter/widgets.dart';

typedef OnBuild<T> = T Function();
typedef WidgetBuilder<T> = Widget Function(BuildContext, T?);

/// Observes a [BuildOwner],
/// whenever it will build, calculates a value via [onBuild],
/// finally it schedules its own build and invokes [builder] with the
/// obtained value [T].
/// Optionally pass in [initialValue] for the above obtained value during initial build.
class BuildObserver<T> extends StatefulWidget {
  final WidgetBuilder<T> builder;
  final BuildOwner owner;
  final OnBuild<T>? onBuild;
  final T? initialValue;

  const BuildObserver({
    Key? key,
    required this.owner,
    required this.builder,
    this.onBuild,
    this.initialValue,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BuildObserverState<T>();
}

class _BuildObserverState<T> extends State<BuildObserver<T>> {
  T? builtValue;
  VoidCallback? onBuildScheduled;

  @override
  void initState() {
    final onBuild = widget.onBuild;

    // cache the original handler
    onBuildScheduled = widget.owner.onBuildScheduled;
    builtValue = widget.initialValue;

    if (onBuild != null) {
      widget.owner.onBuildScheduled = () {
        T? nextValue;

        if (mounted) {
          try {
            nextValue = onBuild();
          } catch (e) {
            // ignore this error if it occurs,
            // it may trigger when widget.owner.onBuildScheduled is invoked,
            // but the target context Widget might be removed.
            // nextValue should then be null.
          }

          if (builtValue != nextValue && nextValue != null) {
            // trigger a rebuild
            setState(() {
              builtValue = nextValue;
            });
          }
        }

        if (onBuildScheduled != null) {
          // exec the original handler
          onBuildScheduled!();
        }
      };
    }

    super.initState();
  }

  @override
  void dispose() {
    // reset the original handler
    widget.owner.onBuildScheduled = onBuildScheduled;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, builtValue);
}
