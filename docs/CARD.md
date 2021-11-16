----------

**Use case #1 (Button with text)**

```dart
  Widget _buildCard(Widget child) => AppCardWidget(
    child: child,
    isHighlighted: true,
    elevation: 12.0,
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    contentPadding: EdgeInsets.zero,
  );
```

----------

## Attributes :gear:

| attribute name  | Datatype              | Default Value               | Description   |
| --              | --                    | --                          | --    |
| `child`         | `Widget?`             | `required`                  | custom child widget   |
| `isHighlighted` | `bool`                | `false`                     | flag, that forces to draw line around card  |
| `elevation`     | `double?`             | `XSizes.elevationHigh`      | card elevation   |
| `contentPadding`| `contentPadding`      | `EdgeInsets.all(12)`        | padding, applied to the content widget|
| `borderRadius`  | `BorderRadiusGeometry`| `BorderRadius.circular(8)`  | radius, that apply for every corner  |
| `key`           | `Key?`                | `null`                      | key identifier    |