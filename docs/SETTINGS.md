----------
## Scheme :art:

<img width="666" src="../../TB_3035_settings_widgets_test_and_docs/visuals/widget/settings/scheme.png">

----------

## How to use :building_construction:

Please, check the [example app](../../TB_3035_settings_widgets_test_and_docs/example/lib/screen/xayn_widgets/page/settings_page.dart) to see the use cases.

----------

## Attributes :gear:

**Data models:**
1. [SettingsTileAction](#settingstileaction)
    * [SettingsTileActionText](#settingstileactiontext)
    * [SettingsTileActionIcon](#settingstileactionicon)
    * [SettingsTileActionCircle](#settingstileactioncircle)
    * [SettingsTileActionSwitch](#settingstileactionswitch)
2. [SettingsTileData](#settingstiledata)
3. [SettingsGroupData](#settingsgroupdata)
4. [SettingsCardData](#settingscarddata)
5. [SettingsSelectableData](#settingsselectabledata)

**Widgets:**
1. [SettingsTile](#settingstile)
1. [SettingsGroup](#settingsgroup)
1. [SettingsCard](#settingscard)
1. [SettingsSelectable](#settingsselectable)
1. [SettingsSection](#settingssection)

### SettingsTileAction

| attribute name    | Datatype       | Default Value | Description |
| --                | --             | --            | --  |
| `onPressed`       | `VoidCallback` | `required`    | callback, that will be called when action clicked  |
| `key`             | `Key`          | `required`    | key identifier, will be attached to the action widget  |


### SettingsTileActionText

(extends [SettingsTileAction](#settingstileaction))
| attribute name  | Datatype    | Default Value | Description |
| --              | --          | --            | --  |
| `text`          | `String`    | `required`    | text, used in the action button   |


### SettingsTileActionIcon

(extends [SettingsTileAction](#settingstileaction))
| attribute name  | Datatype    | Default Value | Description |
| --              | --          | --            | --  |
| `svgIconPath`   | `String`    | `required`    | file path for the SVG icon, used in the action button |


### SettingsTileActionCircle

(extends [SettingsTileAction](#settingstileaction))
| attribute name  | Datatype    | Default Value | Description |
| --              | --          | --            | --  |
| `svgIconPath`   | `String`    | `required`    | file path for the SVG icon, used in the action button |
| `isActive`      | `bool`      | `required`    | flag, that impact on the colorful state of the action button |


### SettingsTileActionSwitch

(extends [SettingsTileAction](#settingstileaction))
| attribute name  | Datatype    | Default Value | Description |
| --              | --          | --            | --  |
| `value`         | `bool`      | `required`    | flag, that specifies the current switch action state: `on` / `off` |


### SettingsTileData

| attribute name  | Datatype              | Default Value | Description |
| --              | --                    | --            | --  |
| `title`         | `String`              | `required`    | text, shown as a title inside `SettingsTile` widget |
| `action`        | `SettingsTileAction?` | `null`        | optional model, that describes action button |
| `svgIconPath`   | `String?`             | `null`        | optional file path for the tile leading icon |
| `subTitle`      | `String?`             | `null`        | optional text, shown as a subtitle in `SettingsTile` widget |


### SettingsGroupData

| attribute name  | Datatype                 | Default Value | Description |
| --              | --                       | --            | --  |
| `title`         | `String`                 | `null`        | optional text, shown as a title of the group widget in `SettingsGroup` widget |
| `items`         | `List<SettingsTileData>` | `required`    | list of the [SettingsTileData](#settingstiledata), that will be shown inside of the `SettingsGroup` widget  |


### SettingsCardData

| attribute name  | Datatype                    | Default Value | Description |
| --              | --                          | --            | --  |
| `items`         | `List<SettingsGroupData>`   | `required`    | list of the [SettingsGroupData](#settingsgroupdata), that will be shown inside of the `SettingsCard` widget  |


### SettingsSelectableData

| attribute name  | Datatype        | Default Value | Description |
| --              | --              | --            | --  |
| `key`           | `Key`           | `required`    | key identifier, will be attached selectable item widget  |
| `title`         | `String`        | `required`    | text, shown as a title for an item in `SettingsSelectable` widget |
| `svgIconPath`   | `String`        | `required`    | file path for the SVG icon, used for an item in `SettingsSelectable` widget   |
| `isSelected`    | `bool`          | `required`    | flag, that impacts the colorful (selected) state of the item widget in `SettingsSelectable`   |
| `onPressed`     | `VoidCallback`  | `required`    | callback, that will be called when the item clicked |


### SettingsTile

| attribute name  | Datatype           | Default Value | Description |
| --              | --                 | --            | --  |
| `data`          | `SettingsTileData` | `required`    | data model, that describes content for the widget  |
| `key`           | `Key`              | `null`        | key identifier |


### SettingsGroup

| attribute name  | Datatype           | Default Value | Description |
| --              | --                 | --            | --  |
| `data`          | `SettingsGroupData`| `required`    | data model, that describes content for the widget  |
| `key`           | `Key`              | `null`        | key identifier |


### SettingsCard

| attribute name  | Datatype           | Default Value | Description |
| --              | --                 | --            | --  |
| `data`          | `SettingsCardData` | `required`    | data model, that describes content for the widget  |
| `key`           | `Key`              | `null`        | key identifier |


### SettingsSelectable

| attribute name  | Datatype                 | Default Value | Description |
| --              | --                       | --            | --  |
| `items`         | `List<SettingsCardData>` | `required`    | list of selectable models, that will be shown inside the widget |
| `key`           | `Key`                    | `null`        | key identifier |


### SettingsSection

| attribute name  | Datatype                 | Default Value | Description |
| --              | --                       | --            | --  |
| `title`         | `String`                 | `required`    | text, used as a title for the settings section |
| `items`         | `List<SettingsCardData>` | `required`    | list of card models, that belong to the current section   |
| `subTitle`      | `String?`                | `null`        | optional text, that describes section with some details  |
| `key`           | `Key`                    | `null`        | key identifier |

----------

