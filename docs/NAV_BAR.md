----------

`NavBar` allows you to show a bottom bar over all other widgets (and screens).

----------

## Installing :hammer_and_wrench:

To be able to use `NavBar` you need:

1. Add `NavBarObserver` to `navigatorObservers` in your `MaterialApp` (or similar):

    ```dart
    final materialApp = MaterialApp(
      ...
      navigatorObservers: [NavBarObserver()],
    );
    ```
2. Add `NavBar` widget in a widget tree on top of your `materialApp` widget (or similar):

    ```dart
    final stack = Stack(
      children: [
        materialApp,
        const Positioned.fill(top: null, child: NavBar()),
      ],
    );
    ```
3. Wrap `stack` (or similar) in `NavBarContainer` and then wrap it in `MaterialApp` widget:

    ```dart
    // this one used to style properly NavBar components
    // it should be the same as your App class
    final root = MaterialApp(
      home: NavBarContainer(child: stack),
      theme: materialApp.theme,
    );
    ```
4. You are ready to go :tada:

----------

## How to use :building_construction:

`NavBarContainer` is responsible for picking and handling config for the `NavBar`.
Every time `NavBarContainer.resetBar` is called (should be used internally from `NavBarObserver` only),
it will walk through the widget tree from up to down and search for all widgets that implement `NavBarConfigMixin`.
Then it will try to _show_ the latest (valid) `NavBarConfig` inside the `NavBar`.

When you would like to show `NavBar` for some screen (stateful or stateless widget), you need to
implement [NavBarConfigMixin] in that class:

```dart
class _NavBarHomeScreenState extends BaseNavBarScreenState<NavBarHomeScreen>
    with NavBarConfigMixin {

  bool isLiked = false;

  @override
  NavBarConfig get navBarConfig {
    final home = NavBarItemIconButton(
      svgIconPath: linden.assets.icons.home,
      isHighlighted: true,
      onPressed: () {},
      key: keyHome,
    );
    final like = NavBarItemIconButton(
      svgIconPath: isLiked
          ? linden.assets.icons.thumbsUpActive
          : linden.assets.icons.thumbsUp,
      isHighlighted: false,
      onPressed: () {},
      key: keyLike,
    );
    return NavBarConfig([
      home,
      like
    ]);
  }
```

In this way you can describe different content of the `NavBar` for different screens. And then
[NavBarObserver] will take care of changing those configs when `navigation` happens between screens.

If you need to notify `NavBar` that config was changed for the current screen 
(i.e. `isLiked` become `true`), provide those changes in `NavBarConfig get navBarConfig` 
and then call `NavBarContainer.updateNavBar(context)`. 

There are 4 types of `NavBar` which you can control via different constructors of the `NavBarConfig`:

1. `NavBarConfig(...)` - default constructor. Will create a rounded card with items for you.
2. `NavBarConfig.hidden()` - will show nothing (hide `NavBar`) when current widget is shown.
3. `NavBarConfig.ignored()` - will ignore current `NavBarConfigMixin` and will try to render previous `NavBarConfigMixin` in the the widget tree.
4. `NavBarConfig.backBtn(...)` - will show back button in the left bottom corner.

For more details please check the `example app` as well as detailed docs for the [`NavBar`-related components](#related-components).

----------

## Limitations :exclamation:

1. Inside `NavBarContainer` widget there should be `NavBar` child. Otherwise you will receive exception.
2. There should be **ONE** instance of the `NavBar` per `NavBarContainer` in the widget tree. Otherwise you will receive exception
3. If you will use `NavBarContrainer` with the `BuildContext` that does not contain `NavBarContainer` - you will receive exception.
   
----------


## Related components
1. [NavBarContainer](../docs/nav_bar/NAV_BAR_CONTAINER.MD)
2. [NavBar](../docs/nav_bar/NAV_BAR.MD)
3. [NavBarObserver](../docs/nav_bar/NAV_BAR_OBSERVER.MD)
4. [NavBarConfigMixin](../docs/nav_bar/NAV_BAR_CONFIG_MIXIN.MD)
5. [NavBarConfig](../docs/nav_bar/NAV_BAR_CONFIG.MD)
6. [NavBarItem](../docs/nav_bar/NAV_BAR_ITEM.MD)

----------