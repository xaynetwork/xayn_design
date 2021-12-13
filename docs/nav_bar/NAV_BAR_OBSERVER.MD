----------

`NavBarObserver` extends `NavigatorObserver` and should be added to your `application` widget
(please check example app or [NavBar how-to-use](../NAV_BAR.md#how-to-use-building_construction))
There is nothing more you need to do with this class.

----------

## How it works

It is responsible for calling [NavBarContainer](../nav_bar/NAV_BAR_CONTAINER.MD)`.reset` method with
the `BuildContext` and `bool`.

`BuildContext` is taken from the `Navigator`. If navigator is `null`, nothing will happen.
`goingBack` is a flag, that notify `NavBarContainer` that navigation is going back (obvious right? :smile: )
This mean that `true` value will be passed only when `didPop` method is called. The rest will
trigger `resetNavBar` method with `false` value.

----------