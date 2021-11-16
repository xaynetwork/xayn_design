----------

**Use case #1 (Button with text)**

```dart
  Widget _buildBtn() => AppRaisedButton.text(
    onPressed: (){},
    text: 'Hello text',
  );
```

**Use case #2 (Button with icon)**

```dart
  Widget _buildBtn() => AppRaisedButton.icon(
    onPressed: (){},
    svgIconPath: someSvgIconPath,
    color: ButtonColor.secondary,
  );
```

**Use case #3 (Button with text and icon)**

```dart
  Widget _buildBtn() => AppRaisedButton.textWithIcon(
    onPressed: (){},
    text: 'Text with icon',
    svgIconPath: someSvgIconPath,
    color: ButtonColor.tertiary,
  );
```

**Use case #4 (Button custom widget)**

```dart
  Widget _buildBtn() => AppRaisedButton(
    child: SvgPicture.asset(linden.assets.illustrations.brainyEnabled),
    onPressed: null,
    color: color,
    minSizeEqual: minSizeEqual,
  );
```

----------

## Attributes :gear:

| attribute name  | Datatype            | Default Value         | Description   | 
| --              | --                  | --                    | --    | 
| `onPressed`     | `VoidCallback?`     | `required`            | callback, called when button pressed  |
| `child`         | `Widget?`           | `required`            | custom child widget   |
| `color`         | `ButtonColor`       | `ButtonColor.primary` | One of the custom color, used for Xayn apps   |
| `contentPadding`| `contentPadding`    | `EdgeInsets.all(12)`  | padding, applied to the content widget|
| `minSizeEqual`  | `bool`              | `false`               | flag, that forces to use same minWidth and minHeight  |
| `circle`        | `boll`              | `false`               | used only for button with icon. flag, that forces to use circle shape  |
| `key`           | `Key?`              | `null`                | key identifier    |