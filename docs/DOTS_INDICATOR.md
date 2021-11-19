----------

**Use case #1 (Dots Indicator with Xayn decorator)**

```dart
    Widget _buildDotsIndicator() => DotsIndicator(
        activePosition: _currentPageIndex,
        dotsNumber: _pagesNumber,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        );
```

**Use case #2 (Dots Indicator with custom decorator)**

```dart
    Widget _buildDotsIndicator() => DotsIndicator(
        activePosition: _currentPageIndex,
        dotsNumber: _pagesNumber,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        decorator: const DotsDecorator(
            color: Colors.orange,
            activeColor: Colors.blue,
          ),
        );
```

----------

## Attributes :gear:
1. [DotsIndicator](#dotsIndicator)
1. [DotsDecorator](#dotsDecorator)
### DotsIndicator

| attribute name     | Datatype            | Default Value              | Description   | 
| --                 | --                  | --                         | --    | 
| `key`              | `Key`               | `null`                     | key identifier |
| `dotsNumber`       | `int`               | `required`                 | the number of the dots to show |
| `activePosition`   | `int`               | `required`                 | the index of the active dot | 
| `decorator`        | `DotsDecorator`     | `null`                     | the object containing the design for the dot |
| `mainAxisAlignment`| `MainAxisAlignment` | `MainAxisAlignment.center` | how the dots should be placed along the main axis of the row |    
| `mainAxisSize`     | `MainAxisSize`      | `MainAxisSize.min`         | how much space the dots should occupy in the main axis |

### DotsDecorator

| attribute name     | Datatype            | Default Value              | Description   | 
| --                 | --                  | --                         | --    | 
| `color`            | `Color`             | `Colors.transparent`       | inactive dot color |
| `activeColor`      | `Color`             | `Colors.white`             | active dot color |
| `borderColor`      | `Color`             | `Colors.white`             | dot border color |
| `borderWidth`      | `double`            | `2.0`                      | dot border width |
| `spacing`          | `EdgeInsets`        | `EdgeInsets.all(4.0)`      | space between dots |
| `shape`            | `BoxShape`          | `BoxShape.circle`          | dot shape |
| `size`             | `Size`              | `Size.square(12.0)`        | dot size |