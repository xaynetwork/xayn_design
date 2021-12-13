----------

`NavBarContainer` is a widget, that should be at the top level of the hierarchy, to be able to control `config` and `NavBar`.

Under the hood this widget is responsible for the orchestrating work, finding desired [NavBarConfig](../nav_bar/NAV_BAR_CONFIG.MD),
and then showing it in the [NavBar](../nav_bar/NAV_BAR.MD).

----------

## Constructor

| attribute name  | Datatype    | Default Value | Description |
| --              | --          | --            | --  |
| `child`         | `Widget`    | `required`   | Children widget, that should contain _application_ widget together with the `NavBar` |
| `key`           | `Key?`      | `null`        | key identifier  |


## Static methods to control

| name              | Params                                    | Description |
| --                | --                                        |  --  |
| `updateNavBar`    | `BuildContext context`                    | Call this, when you need to update current `NavBarConfig` in the `NavBar`. |
| `resetNavBar`     | `BuildContext context`, `bool goingBack`  | **This method used internally** (from [NavBarObserver](../nav_bar/NAV_BAR_OBSERVER.MD)). |
|                   |                                           | Will initiate walk through the children widgets, find the latest instance of 'NavBarConfig' and if it is not 'null', then will draw `NavBar` with it.| 
|                   |                                           | If not `NavBarConfig` found - `NavBar` will be not shown(removed) `goingBack` is a flag, that indicates that navigation flow going back. |
|                   |                                           | When `true`, then will ignore latest `NavBarConfig` (from screen that will be removed) and will try to apply previous `NavBarConfig` (from screen that will be shown instead) |

Both methods (`updateNavBar` and `resetNavBar`) are triggering method that update `NavBar` with proper 
`NavBarConfig` via the stream with debounce. This one needed to prevent very often updating of the `NavBar`.

----------