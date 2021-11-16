----------

```dart
  Widget _buildSwitch() => AppSwitchWidget(
    value: isSwitchOn,
    onToggle: (bool newValue) {
      setState(() {
        isSwitchOn = newValue;
      });
    },
);
```

----------

## Attributes :gear:

| attribute name  | Datatype              | Default Value | Description | 
| --              | --                    | --            | --  | 
| `value`         | `bool`                | `required`    | flag, that describe state, `on` or `off` |
| `onToggle`      | `ValueChanged<bool>?` | `required`    | callback, via which you can receive new state |
| `key`           | `Key?`                | `null`        | key identifier  |