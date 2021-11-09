Xayn-styled shared design elements like icons, colors, styles, and themes.
We expose one design object with the name of `Linden` that contains all the shared design elements.

----------

## Installing :hammer_and_wrench:

Add this to your package's `pubspec.yaml` file:
```yaml
flutter:
  fonts:
  # Add the fonts that you will use in your app
    - family: NotoSans
      fonts:
        - asset: packages/xayn_design/assets/fonts/NotoSans-Regular.ttf
          weight: 400
        - asset: packages/xayn_design/assets/fonts/NotoSans-Bold.ttf
          weight: 700
    - family: Roboto
      fonts:
        - asset: packages/xayn_design/assets/fonts/KFOmCnqEu92Fr1Me5WZLCzYlKw.ttf
          weight: 400
  assets:
    - packages/xayn_design/`path to asset` 
```

_for assets, check [Importing assets in `pubspec.yaml`](#troubleshooting-thinking) for more info._

----------

## How to use `Linden` :building_construction:

The top-level widget in the app should be `UnterDenLinden`. Idealy it should wrap your app widget.
This widget is responsible for storing `Linden` and also provide mechanisms for changing `brightness` 
and using `Linden` by the internal widgets (part of the `xayn_design`) 

```dart
final unterDenLinden = UnterDenLinden(
  child: MyApp(),
  initialLinden: Linden(),
  onLindenUpdated: (final Linden newLinden) {
    // will be called every time, when `Linden` updated
  },
);

runApp(unterDenLinden);
```

**Use case #1 (accessing `Linden`)**

You can access `Linden` with the `BuildContext`:
```dart
final linden = UnterDenLinden.getLinden(context);
```
**Remember:**
It should be called ONLY inside the [build] method.
If you will use it inside the builders - it might leak to the exception:
``` Looking up a deactivated widget's ancestor is unsafe.```

**Use case #2 (using `Linden`)**
```dart
MaterialApp(
..
  theme: linden.themeData,
);
```

**Use case #2 (update `brightness`)**
```dart
final newBrightness = Random().nextBool() ? Brightness.light : Brightness.dark;
UnterDenLinden.of(context).changeBrightness(newBrightness);
```

**Use case #3 (for the internal `xayn_design` widgets)**

If you need to build internal widget and at the same time you need rely on the current `Linden`,
you have 2 options:
1. get `Linden` with `UnterDenLinde.getLinden(context)`
2. for the `StatefullWidget` you can add `mixin` - `UnterDenLindenMixin` - it will do same job for you :smile:

```dart
class _TooltipState extends State<Tooltip> with UnterDenLindenMixin {
  ...
```



----------

## Attributes :gear:

#### Linden

| attribute name                | Datatype      | Default Value                                                                                                                 | Description   |
| --                            | --            | --                                                                                                                            | --    |
| `brightness`                  | `Brightness`  | `Brightness.light`                                                                                                            | Responsible for switching theme from light to dark and vise versa.    |
| `styles`                      | `XStyles`     | `XStyles(_defaultTheme(brightness).textTheme, brightness: brightness,)`                                                       | Responsible for `TextStyles` in the app as well as any other shared `Material` style we use in the design system.     |
| `themeData`                   | `ThemeData`   | `_defaultTheme(brightness, styles: styles)`                                                                                   | Provides theme configuration for `Linden` and in case nothing is passed, the private defaultTheme is used.    |
| `dimen`                       | `XSizes`      | `XSizes(notchPaddingLandscapeMode: notchPaddingLandscapeMode, deviceOrientation: deviceOrientation, screenSize: screenSize,)` | All the dimensions is the responsibility of `dimen`. It's dependent on the configuration pf `XSizes` class.    |
| `colors`                      | `XColors`     | `XColors(brightness: brightness)`                                                                                             | The shared colors configuration.  |
| `assets`                      | `XAssets`     | `XAssets(brightness: brightness)`                                                                                             | Assets' configuration.    |
| `animations`                  | `XAnimations` | `XAnimations()`                                                                                                               | Animations' parameters, mostly `duration`s, configurations.   |
| `screenSize`                  | `Size?`       | `null`                                                                                                                        | Responsible for the screen size and eventually updates the `XSizes` instance, `dimen`, when altered.  |
| `deviceOrientation`           | `Orientation` | `Orientation.portrait`                                                                                                        | Passes the state of the device orientation and updates the `XSizes` instance, `dimen`, when altered.  |
| `notchPaddingLandscapeMode`   | `double`      | `0`                                                                                                                           | When in landscape mode, regardless of the orientation; left or right, if there is a notch both `padding.right` and `padding.left` return the notch padding value. It updates the `XSizes` instance, `dimen`, when altered.    |

#### UnterDenLinden

| attribute name    | Datatype          | Default Value | Description   |
| --                | --                | --            | --    |
| `child`           | `Widget`          | `required`    | Your app widget   |
| `initialLinden`   | `Linden`          | `required`    | Initial `Linden`, that will be stored inside `UntgerDenLinden` and will later updated and populated to the rest of the app |
| `onLindenUpdated` | `OnLindenUpdated` | `null`        | Callback, that will be emitted everytime when `Linden` changes inside `UnterDenLinden`    |
