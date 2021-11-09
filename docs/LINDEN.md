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

First you'd need to store an instance of `Linden` in your preferred state management solution.
```dart
Linden linden = Linden;
```
Make sure it's exposed to the `MaterialApp`, in case you plan update the theme.


**Use case #1 (using `Linden` theme)**
```dart
MaterialApp(
..
  theme: linden.themeData,
);
```

**Use case #2 (update theme)**
```dart
linden = linden.updateBrightness(brightness);
```

**Use case #3 (update screen information)**
```dart
linden = linden.updateScreenInfo(
      screenSize: screenSize,
      deviceOrientation: deviceOrientation,
      notchPaddingLandscapeMode: notchPaddingLandscapeMode,
    );
```

----------

## Attributes :gear:

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
