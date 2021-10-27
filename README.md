# xayn_design

[![codecov](https://codecov.io/gh/xaynetwork/xayn_design/branch/main/graph/badge.svg)](https://codecov.io/gh/xaynetwork/xayn_design)
[![Build Status](https://github.com/xaynetwork/xayn_design/actions/workflows/flutter_post_merge.yaml/badge.svg)](https://github.com/xaynetwork/xayn_design/actions)

`xayn_design` library is a shared plugin that provides xayn-styled shared design elements like icons, colors, styles, and themes. We expose one design object with the name of `Linden` that exposes all the shared design elements.

----------



## Table of content:

 * [Installing :hammer_and_wrench:](#installing-hammer_and_wrench)
 * [How to use :building_construction:](#how-to-use-building_construction)
 * [Attributes :gear:](#attributes-gear)
 * [Troubleshooting :thinking:](#troubleshooting-thinking)
 * [Contributing :construction_worker_woman:](#contributing-construction_worker_woman)
 * [License :scroll:](#license-scroll)

----------



## Installing :hammer_and_wrench:

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  xayn_design: `latest version`

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

After that, shoot it on the command line:

```shell
$ flutter pub get
```

----------



## How to use :building_construction:
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

 - please also give a try to the [example app](../main/example/) 

[top :arrow_heading_up:](#xayn_design)

----------



## Attributes :gear:
### Linden
| attribute name| Datatype| Default Value | Description                                  |
| -- | -- | -- | -- |
| `brightness`| `Brightness`| `Brightness.light`| Responsible for switching theme from light to dark and vise versa.   |
| `styles`| `XStyles`| `XStyles(_defaultTheme(brightness).textTheme, brightness: brightness,)`| Responsible for `TextStyles` in the app as well as any other shared `Material` style we use in the design system.  |
| `themeData`| `ThemeData`| `_defaultTheme(brightness, styles: styles)`| Provides theme configuration for `Linden` and in case nothing is passed, the private defaultTheme is used.    |
| `dimen`| `XSizes`| `XSizes(notchPaddingLandscapeMode: notchPaddingLandscapeMode, deviceOrientation: deviceOrientation, screenSize: screenSize,)`    | All the dimensions is the responsibility of `dimen`. It's dependent on the configuration pf `XSizes` class.    |
| `colors`| `XColors`| `XColors(brightness: brightness)`| The shared colors configuration. |
| `assets`| `XAssets`| `XAssets(brightness: brightness)`| Assets' configuration.    |
| `animations`| `XAnimations`| `XAnimations()`| Animations' parameters, mostly `duration`s, configurations. |
| `screenSize`| `Size?`| `null`| Responsible for the screen size and eventually updates the `XSizes` instance, `dimen`, when altered. |
| `deviceOrientation`| `Orientation`| `Orientation.portrait`| Passes the state of the device orientation and updates the `XSizes` instance, `dimen`, when altered.|
| `notchPaddingLandscapeMode`| `double`| `0`| When in landscape mode, regardless of the orientation; left or right, if there is a notch both `padding.right` and `padding.left` return the notch padding value. It updates the `XSizes` instance, `dimen`, when altered. |

[top :arrow_heading_up:](#xayn_design)

----------



## Troubleshooting :thinking:

### Importing assets in `pubspec.yaml`
Until [this Flutter issue](https://github.com/flutter/flutter/issues/27802) is resolved, you'll need to include each asset independently under `assets` in `pubsepc.yaml`. 
Check the [example app](../main/example/pubspec.yaml) to learn more.

[top :arrow_heading_up:](#xayn_design)

----------



## Contributing :construction_worker_woman:

We're more than happy to accept pull requests :muscle:

 - check our [contributing](../main/.github/contributing.md) page
 - found a bug or have a question? Please [create an issue](https://github.com/xaynetwork/xayn_design/issues/new/choose).



[top :arrow_heading_up:](#xayn_design)

----------



## License :scroll:
**xayn_design** is licensed under `Apache 2`. View [license](../main/LICENSE).

[top :arrow_heading_up:](#xayn_design)

----------


