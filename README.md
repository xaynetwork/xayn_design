# xayn_design

[![codecov](https://codecov.io/gh/xaynetwork/xayn_design/branch/main/graph/badge.svg)](https://codecov.io/gh/xaynetwork/xayn_design)
[![Build Status](https://github.com/xaynetwork/xayn_design/actions/workflows/flutter_post_merge.yaml/badge.svg)](https://github.com/xaynetwork/xayn_design/actions)

`xayn_design` library is a plugin that provides:
- **Linden** 
  
    Xayn-styled shared design elements like icons, colors, styles, and themes. 
    We expose one design object with the name of `Linden` that contains all the shared design elements.

- **Widgets**
  
    Common widgets, that we share between our applications.

----------



## Table of content:

 * [Installing :hammer_and_wrench:](#installing-hammer_and_wrench)
 * [Docs :book:](#library-docs-book)
 * [Troubleshooting :thinking:](#troubleshooting-thinking)
 * [Contributing :construction_worker_woman:](#contributing-construction_worker_woman)
 * [License :scroll:](#license-scroll)

----------



## Installing :hammer_and_wrench:

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  xayn_design: `latest version`
```

After that, shoot it on the command line:

```shell
$ flutter pub get
```

----------



## Library docs :book:

 1) [Linden](../main/docs/LINDEN.md)
    * [Installing](../main/docs/LINDEN.md#installing-hammer_and_wrench)
    * [How to use](../main/docs/LINDEN.md#how-to-use-linden-building_construction)
    * [Attributes](../main/docs/LINDEN.md#attributes-gear)
 2) Widgets
    * [Tooltip](../main/docs/TOOLTIP.md)
        * [Installing](../main/docs/TOOLTIP.md#installing-hammer_and_wrench)
        * [How to use](../main/docs/TOOLTIP.md#how-to-use-building_construction)
        * [Attributes](../main/docs/TOOLTIP.md#attributes-gear)
    * [AppSwitch](../main/docs/SWITCH.md)
        * [How to use](../main/docs/SWITCH.md#how-to-use-building_construction)
        * [Attributes](../main/docs/SWITCH.md#attributes-gear)
    * [AppRaisedButton](../main/docs/BUTTON.md)
        * [How to use](../main/docs/BUTTON.md#how-to-use-building_construction)
        * [Attributes](../main/docs/BUTTON.md#attributes-gear)
    * [AppCard](../main/docs/CARD.md)
        * [How to use](../main/docs/CARD.md#how-to-use-building_construction)
        * [Attributes](../main/docs/CARD.md#attributes-gear)
    * [Settings](../main/docs/SETTINGS.md)
    * [DotsIndicator](../main/docs/DOTS_INDICATOR.md)
        * [How to use](../main/docs/DOTS_INDICATOR.md#how-to-use-building_construction)
        * [Attributes](../main/docs/DOTS_INDICATOR.md#attributes-gear)
    * [NavBar](../main/docs/NAV_BAR.md)
        * [Installing](../main/docs/NAV_BAR.md#installing-hammer_and_wrench)
        * [How to use](../main/docs/NAV_BAR.md#how-to-use-building_construction)
        * [Limitations](../main/docs/NAV_BAR.md#limitations-exclamation)
        * [Related components](../main/docs/NAV_BAR.md#related-components)

Give a try to the [example app](../main/example/)

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


