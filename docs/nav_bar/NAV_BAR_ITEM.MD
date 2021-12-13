----------

`NavBarItem` is an abstract data class, that `extends Equatable` and hold some necessary information
that are needed to show proper items inside [NavBar](../nav_bar/NAV_BAR.MD).

`NavBarItem` has a private constructor, so for now it can not be extended outside `nav_bar_item.dart` file.

## Attributes of the `NavBarItem`

| attribute name  | Datatype              | Description |
| --              | --                    | --  |
| `isHighlighted` | `bool`                | flag, that describe the highlighted state. If `true`, then `NavBar` will draw a line below this item. There can be max 1 item with `true` per `NavBarConfig.items` |
| `onPressed`     | `VoidCallback`        | callback, which will be triggered when user clicks on the item |
| `key`           | `Key`                 | key identifier, needed for tests mainly  |

----------

## Successor of the `NavBarItem`

1. `NavBarItemIconButton`
2. `NavBarItemBackButton`
3. `NavBarItemEdit`

----------

## Attributes of the `NavBarItemIconButton`

| attribute name  | Datatype    | Description |
| --              | --          | --  |
| `svgIconPath`   | `String`    | path to the asset icon, that will be used in the item |
|  ...            | ...         | other params from `NavBarItem`    |

## Attributes of the `NavBarItemBackButton`

| attribute name  | Datatype    | Description |
| --              | --          | --  |
|  ...            | ...         | other params from `NavBarItem`    |

## Attributes of the `NavBarItemEdit`

| attribute name    | Datatype                  | Default Value | Description |
| --                | --                        | --            | --  |
| `svgIconPath`     | `String`                  | `required`    | path to the asset icon, that will be used in the item |
| `initialText`     | `String?`                 | `null`        | optional text, that might be used inside the `edit widget` as `initial` |
| `hint`            | `String?`                 | `null`        | optional text, that might be used inside the `edit widget` as `hint` |
| `onTextChanged`   | `Function(String text)?`  | `null`        | optional callback, that will be triggered every time when text changed in the `edit widget` |
| `onSearchPressed` | `Function(String text)`   | `required`    | callback, that will be triggered when user click on the `SEARCH` icon on the keyboard |
| `autofocus`       | `bool`                    | `true`        | flag, if `true` `edit widget` will receive a focus as it become visible. It will force to show the keyboard    |
|  ...              | ...                       | ...           | other params from `NavBarItem`    |

