part of 'nav_bar_container_test.dart';

const keyStack = Key('keyStack');

final _backBtnConfig = NavBarConfig.backBtn(
  NavBarItemBackButton(onPressed: () {}, key: const Key('back btn')),
);

final _ignoredConfig = NavBarConfig.ignored();

final _singleItemConfig = creteConfig();

BuildContext getContext() => find.byKey(keyStack).evaluate().first;

NavBarContainerState getState() =>
    (find.byType(NavBarContainer).evaluate().first as StatefulElement).state
        as NavBarContainerState;

NavBarState getStateNavBar() =>
    (find.byType(NavBar).evaluate().first as StatefulElement).state
        as NavBarState;

NavBarConfig creteConfig({int numberOfItems = 1}) {
  assert(numberOfItems >= 1, 'There should be at least 1 item');
  final items = <NavBarItem>[];

  for (int i = 0; i < numberOfItems; i++) {
    final item = NavBarItemIconButton(
      svgIconPath: 'packages/xayn_design/assets/icons/arrow_left.svg',
      isHighlighted: i == 0,
      onPressed: () {},
      key: Key('item-$i'),
    );
    items.add(item);
  }
  return NavBarConfig(items);
}

void resetNavBar({BuildContext? context, goingBack = false}) =>
    NavBarContainer.resetNavBar(context ?? getContext(), goingBack: goingBack);

void updateNavBar({BuildContext? context}) =>
    NavBarContainer.updateNavBar(context ?? getContext());

NavBarContainer buildWidget({
  Widget? child,
  bool withNavBar = true,
}) =>
    NavBarContainer(
        child: Stack(
      key: keyStack,
      children: [
        child ?? const SizedBox(),
        withNavBar ? const NavBar() : const SizedBox(),
      ],
    ));

typedef GetConfigCallback = NavBarConfig Function();

class _StatelessConfigWidget extends StatelessWidget with NavBarConfigMixin {
  final Widget? child;
  final GetConfigCallback getConfigCallback;

  const _StatelessConfigWidget(
    this.getConfigCallback, {
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => child ?? const Center();

  @override
  NavBarConfig get navBarConfig => getConfigCallback();
}

class _StatefulConfigWidget extends StatefulWidget {
  final Widget? child;
  final GetConfigCallback getConfigCallback;

  const _StatefulConfigWidget(
    this.getConfigCallback, {
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  _StatefulConfigWidgetState createState() => _StatefulConfigWidgetState();
}

class _StatefulConfigWidgetState extends State<_StatefulConfigWidget>
    with NavBarConfigMixin {
  @override
  Widget build(BuildContext context) => widget.child ?? const Center();

  @override
  NavBarConfig get navBarConfig => widget.getConfigCallback();
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> resetNavBarWithDebounce({
    BuildContext? context,
    goingBack = false,
  }) async {
    resetNavBar(context: context, goingBack: goingBack);
    await pumpAndSettle(updateNabBarDebounceTimeout);
  }
}
