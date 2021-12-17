----------

Data class, that describe how exactly and what exactly `NavBar` should show.

## Variables

| name                  | Datatype              | Description   |
| --                    | --                    | --    |
| `items`               | `List<NavBarItem>`    | List of [NavBarItem](../nav_bar/NAV_BAR_ITEM.MD)s that will be shown inside [NavBar](../nav_bar/NAV_BAR.MD)|
| `isWidthExpanded`     | `bool`                | Flag, that used to expand to the possible maximum width. Also when `true` all items in a [Row] will be placed with [MainAxisAlignment.spaceBetween]   |
| `showAboveKeyboard`   | `bool`                | Flag, that used when `NavBar` should respect the keyboard height. When `true` the keyboard height will be added to the default bottom padding. |
| `type`                | `NavBarType`          | Private `enum`, that categorize config to the different types. [NavBarType](#navbartype) is hidden externally and `type` is used together with  `NavBarTypeExtension` described in same file   |

## Constructors

| name          | Params                              | Description   |
| --            | --                                  | --    |
| `._(...)`     | `items`, `isWidthExpanded`,         | Default `private` constructor. |
|               | `type`, `showAboveKeyboard`         | Receive all possible params.  |
| `(...)`       | `items`, `isWidthExpanded = false`, | Default `public` constructor. Used to show items in card. `type` = `NavBarType.card`. |
|               | `showAboveKeyboard = true`          | Items can not be empty. Also items should not contain `NavBarItemBackButton`. |
| `hidden()`    |                                     | Use it when need to hide `NavBar`. `type` = `NavBarType.hidden`. |
|               |                                     | Items are empty. `isWidthExpanded` = `false`. `showAboveKeyboard` = `false` |
| `ignored()`   |                                     | Use it when need to ignore implementation of the [NavBarConfigMixin](../nav_bar/NAV_BAR_CONFIG_MIXIN.MD). | 
|               |                                     | `type` = `NavBarType.ignored`. Items are empty. `isWidthExpanded` = `false`. `showAboveKeyboard` = `false` |
| `backBtn(...)`| `NavBarItemBackButton`              | Use it when need to show back button instead of a card. `type` = `NavBarType.backBtn`. |
|               |                                     | Items contain just one item of `NavBarItemBackButton`. `isWidthExpanded` = `false`. `showAboveKeyboard` = `false` |

## NavBarType

1. `card` - value, that applied to the default constructor of the `NavBarConfig`. 
   With this type all items will be shown inside [AppCard](../CARD.md)
2. `backBtn` - With this type `card` will be hidden and instead of it 
   will be shown floating action button with arrow icon.
3. `hidden` - When this type applied, `NavBar` will show nothing. 
   Needed, if you want to hide `NavBar` for some screen, for example `OnboardingScreen`.
4. `ignored` - When this type applied, `NavBarContainer` will ignore current config 
   and try to show in the `NavBar` config from the previous widget in the widget tree, 
   that implement [NavBarConfigMixin](../nav_bar/NAV_BAR_CONFIG_MIXIN.MD) 

