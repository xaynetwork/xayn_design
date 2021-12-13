----------

`Mixin` class, that should be used with [StatelessWidget] or with the [State] of [StatefulWidget].

Every time `NavBarContainer.reset` is called, `NavBarContainer` will walk through the children 
widget-tree and search for the widgets, that implement this `mixin`. 
Later the latest implementation of `NavBarConfigMixin` will be used to get [NavBarConfig](../nav_bar/NAV_BAR_CONFIG.MD)
and to show it inside [NavBar](../nav_bar/NAV_BAR.MD).

Contains only one `getter`, which is `NavBarConfig get navBarConfig`.

In this way class that implements this `mixin` will be forced to describe desired config for the `NavBar`.

----------