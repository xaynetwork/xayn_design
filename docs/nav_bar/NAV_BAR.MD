----------

`NavBar` is a widget, that is responsible for building children widgets, based on the `NavBarConfig`, 
provided by `NavBarContainer`.

`NavBar` should be added to the widget tree, inside `NavBarContiner`, on top of the rest application widget.
Here is example, how it might look:

```dart
final stack = Stack(
      children: [
        materialApp,
        const Positioned.fill(top: null, child: NavBar()),
      ],
    );

    // this one used to style properly NavBar components
    // it should be the same as your App class
    final root = MaterialApp(
      home: NavBarContainer(child: stack),
      theme: materialApp.theme,
    );
```

There can be only **one** `NavBar` per `NavBarContainer` in the widget tree.


----------

## Attributes :gear:

| attribute name        | Datatype      | Default Value                 | Description   |
| --                    | --            | --                            | --    |
| `padding`             | `EdgeInsets`  | `EdgeInsets.all(16)`          | Padding, that applied around the `NavBar` content. Apply only when config `type` is `NavBarType.card` (for more details see [NavBarConfig](../nav_bar/NAV_BAR_CONFIG.MD))  |
| `key`                 | `Key?`        | `null`                        | key identifier    |

----------