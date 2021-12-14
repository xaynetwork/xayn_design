`Tooltip` allows you to show tooltip messages, something like Android toasts, but in a dart way :smile:

----------

## Installing :hammer_and_wrench:

To be able to use `Tooltip` you need create `TooltipController` and `ApplicationTooltipController`
and path them to the `Provider`:

```dart
  @override
Widget build(BuildContext context) =>
    MultiProvider(
      providers: _getProviders(),
      child: MaterialApp(title: 'Flutter Demo'),
      onGenerateRoute: createCupertinoPageRoute,
    );

List<SingleChildWidget> _getProviders() =>
    [
      ChangeNotifierProvider<TooltipController>.value(
          value: _tooltipController),
      Provider<ApplicationTooltipController>.value(
          value: _applicationTooltipController),
    ];
```

Then every screen, where you would like to show `Tooltip` (or all of them), should be wrapped with

```dart
PageRoute? createCupertinoPageRoute(RouteSettings routeSettings) {
  late final Widget? screenWidget;
  switch (routeSettings.name) {
  // create your screen here
    default:
      screenWidget = null;
  }

  if (screenWidget == null) return null;

  return CupertinoPageRoute(
    builder: (_) =>
        ApplicationTooltipProvider(
          messageFactory: TooltipMessageProvider.of(),
          child: screenWidget,
        ),
    settings: routeSettings,
  );
}
```

One more thing and we are ready `to go`. You need to provide `Map<TooltipKey, TooltipParams>`. It
can be a single one for the whole app, or individual per screen. Depends on your need and taste.

----------

## How to use :building_construction:

### So, `Map<TooltipKey, TooltipParams>`.

```dart
class TooltipKeys {
  TooltipKeys._();

  static const simple = TooltipKey('simple');
  static const withIcon = TooltipKey('with_icon');
}

abstract class TooltipMessageProvider {
  TooltipMessageProvider._();

  static MessageFactory of() =>
      {
        TooltipKeys.simple: TooltipParams(
          label: 'This is simple tooltip',
          builder: (_) => const TextualNotification(),
        ),
      };
}
```

where

- `TooltipKey` - object, key, that we will use later to request `show` `Tooltip`
- `TooltipParams` - object, that contain all necessary data, that framework need to know to build
  and show `Tooltip`

**Use case #1 (show `Tooltip`)**

To show some tooltips you need to add `TooltipStateMixin` or `TooltipStatelessMixin`. Then simply do
next:

```dart
void _someBtnClick() {
  showTooltip(TooltipKeys.simple);
}
```

**Use case #2 (anchor `Tooltip`)**

By default `Tooltip` will be shown in the middle of the screen. But you can _attach_ it to
some `anchor` widget, by wrapping that widget in `TooltipContextProvider`:

```dart
Widget _buildWidget(){
  final fab = FloatingActionButton(
    onPressed: () {},
    child: SvgPicture.asset(linden.assets.icons.moon),
  );
  return TooltipContextProvider (child: fab);
}
```

When its done, framework will try to show tooltip above that widget (if there is enough space :
wink:). If there is not enough space - `Tooltip` will be shown below. Also when we `attach`
to `anchot` - it will _follow_ it (until its visible). 

For example if we attach `Tooltip` to the `bottimBar` - it will be shown above it, when its visible. 
But if `bottomBar` will be hiding (during user scroll) - `Tooltip` will _follow_ 
it until its gone and then will be shown on the bottom of the screen

Only the latest `TooltipContextProvider` in the widget tree will be used. Keep in mind :wink:

**Use case #3 (register dynamic `Tooltip`)**

With help of `TooltipStateMixin` or `TooltipStatelessMixin` you also can register a **dynamic** one.
Once it registered, it can be shown later from anywhere via same way.

```dart
void _registerDynamicTooltips() {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _registerDynamicTooltips();
    });
    super.initState();
  }

  registerTooltip(
    key: TooltipKeys.withIcon,
    params: TooltipParams(
      label: 'Undo action',
      builder: (_) =>
          TextualNotification(
            onTap: (parameters) {},
          ),
    ),
  );
}
```

As you can see from the code above, you can not register `Tooltip` until `context` is _ready_ :wink:

----------

## Attributes :gear:

1. [ApplicationTooltipProvider](#applicationtooltipprovider)
1. [TooltipContextProvider](#tooltipcontextprovider)
1. [TooltipKey](#tooltipkey)
2. [TooltipParams](#tooltipparams)
3. [TooltipStateMixin](#tooltipstatemixin)
4. [TooltipStatelessMixin](#tooltipstatelessmixin)

### ApplicationTooltipProvider

| attribute name    | Datatype          | Default Value | Description | 
| --                | --                | --            | --  | 
| `messageFactory`  | `MessageFactory`  | `required`    | `Map<TooltipKey, TooltipParams>` that should be used for this provider  |
| `child`           | `Widget`          | `required`    | widget, for which provider will provide `Tooltip`'s. Ideally should be _screen_ widget |
| `key`             | `Key?`            | `null`        | key identifier  |

### TooltipContextProvider

| attribute name    | Datatype          | Default Value | Description | 
| --                | --                | --            | --  |
| `child`           | `Widget`          | `required`    | widget, which will be an anchor for the `Tooltip` |
| `key`             | `Key?`            | `null`        | key identifier  |


### TooltipKey

| attribute name  | Datatype  | Default Value | Description     | 
| --              | --        | --            | --              | 
| `value`         | `String`  | `required`    | key identifier  |


### TooltipParams

| attribute name  | Datatype          | Default Value | Description     | 
| --              | --                | --            | --              | 
| `label`         | `String`          | `required`    | text, that will be shown inside the `Tooltip` |
| `builder`       | `MessageBuilder`  | `required`    | callback, that receive `BuildContext` and should return the _body_ for the `Tooltip`  |

### TooltipStateMixin

 - `registerTooltip` method

| method name | Datatype        | Default Value | Description |
| --          | --              | --            | --  |
| `key`       | `TooltipKey`    | `required`    | identifier of the tooltip, which you want to register  |
| `params`    | `TooltipParams` | `required`    | params, which will be registered with the key |


 - `showTooltip` method

| method name | Datatype          | Default Value | Description |
| --          | --                | --            | --  |
| `key`       | `TooltipKey`      | `required`    | identifier of the tooltip, which you want to show  |
| `params`    | `List<dynamic>?`  | `null`        | dynamic params, that will be emitted inside `ParameterCallback` |

### TooltipStatelessMixin

 - `registerTooltip` method

| method name | Datatype        | Default Value | Description |
| --          | --              | --            | --  |
| `context`   | `BuildContext`  | `required`    | current `contenxts` |
| `key`       | `TooltipKey`    | `required`    | identifier of the tooltip, which you want to register  |
| `params`    | `TooltipParams` | `required`    | params, which will be registered with the key |


 - `showTooltip` method

| method name | Datatype          | Default Value | Description |
| --          | --                | --            | --  |
| `context`   | `BuildContext`    | `required`    | current `contenxts` |
| `key`       | `TooltipKey`      | `required`    | identifier of the tooltip, which you want to show  |
| `params`    | `List<dynamic>?`  | `null`        | dynamic params, that will be emitted inside `ParameterCallback` |
