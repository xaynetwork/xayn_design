import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

enum _DotsColor {
  primary,
  secondary,
  tertiary,
}

enum _DotsColorType {
  general,
  active,
  border,
}

const _kDotsSizeList = [12.0, 16.0, 20.0];
const _kDotsBorderWidthList = [1.0, 2.0, 3.0];
const _kDotsSpacingMap = {
  'All: 4.0': EdgeInsets.all(4.0),
  'Only left: 4.0': EdgeInsets.only(left: 4.0),
  'Only top: 4.0': EdgeInsets.only(top: 4.0),
};

class DotsIndicatorPage extends StatefulWidget {
  const DotsIndicatorPage({
    Key? key,
  }) : super(key: key);

  @override
  _DotsIndicatorPageState createState() => _DotsIndicatorPageState();
}

class _DotsIndicatorPageState extends State<DotsIndicatorPage> {
  late final PageController _pageController;
  late final List<String> _mockedPages;
  final _pagesNumber = 3;

  _DotsColor dotsColor = _DotsColor.primary;
  _DotsColor dotsActiveColor = _DotsColor.primary;
  _DotsColor dotsBorderColor = _DotsColor.primary;
  double dotsSize = 12.0;
  double dotsBorderWidth = 2.0;
  BoxShape dotsShape = BoxShape.circle;
  EdgeInsets dotsSpacing = const EdgeInsets.all(4.0);

  int _currentPageIndex = 0;

  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
    _initValues();
    super.initState();
  }

  void _initValues() {
    _mockedPages = [
      'Swipe left',
      'Swipe left or right',
      'Swipe right',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pageView = PageView.builder(
      controller: _pageController,
      itemCount: _pagesNumber,
      itemBuilder: (_, index) => Center(
        child: Text(
          _mockedPages[index],
          style: TextStyle(
            color: linden.colors.dotsIndicatorActiveColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onPageChanged: (index) => setState(() {
        _currentPageIndex = index;
      }),
    );

    final dotsIndicator = DotsIndicator(
      activePosition: _currentPageIndex,
      dotsNumber: _pagesNumber,
      decorator: DotsDecorator(
        color: _getDotsColor(dotsColor, _DotsColorType.general),
        activeColor: _getDotsColor(dotsActiveColor, _DotsColorType.active),
        borderColor: _getDotsColor(dotsBorderColor, _DotsColorType.border),
        size: Size.square(dotsSize),
        borderWidth: dotsBorderWidth,
        shape: dotsShape,
        spacing: dotsSpacing,
      ),
    );

    final pageWithDots = Container(
      color: linden.colors.onboardingTutorialBackground,
      child: Stack(
        children: [
          pageView,
          Positioned(
            right: .0,
            left: .0,
            bottom: 40.0,
            child: dotsIndicator,
          ),
        ],
      ),
    );
    return Column(
      children: [
        Expanded(
          /// The page with dots has the same design for bright and dark mode.
          /// This Container with the color set to white is needed in order
          /// to correctly show the background color of the page when in dark mode
          /// since the background color has some transparency
          child: Container(
            color: Colors.white,
            child: pageWithDots,
          ),
        ),
        Expanded(
          flex: 3,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              _buildListTileDotsColor(),
              _buildListTileDotsActiveColor(),
              _buildListTileDotsBorderColor(),
              _buildListTileDotsSize(),
              _buildListTileDotsBorderWidth(),
              _buildListTileDotsShape(),
              _buildListTileDotsSpacing(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListTileDotsColor() => ListTile(
        title: const Text('Dots color: '),
        trailing: DropdownButton<_DotsColor>(
          value: dotsColor,
          items: _DotsColor.values.map(_itemBuilderDotsColor).toList(),
          onChanged: (value) {
            setState(() {
              dotsColor = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsActiveColor() => ListTile(
        title: const Text('Dots active color: '),
        trailing: DropdownButton<_DotsColor>(
          value: dotsActiveColor,
          items: _DotsColor.values.map(_itemBuilderDotsColor).toList(),
          onChanged: (value) {
            setState(() {
              dotsActiveColor = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsBorderColor() => ListTile(
        title: const Text('Dots border color: '),
        trailing: DropdownButton<_DotsColor>(
          value: dotsBorderColor,
          items: _DotsColor.values.map(_itemBuilderDotsColor).toList(),
          onChanged: (value) {
            setState(() {
              dotsBorderColor = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsSize() => ListTile(
        title: const Text('Dots size: '),
        trailing: DropdownButton<double>(
          value: dotsSize,
          items: _kDotsSizeList.map(_itemBuilderDotsDimen).toList(),
          onChanged: (value) {
            setState(() {
              dotsSize = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsBorderWidth() => ListTile(
        title: const Text('Dots border width: '),
        trailing: DropdownButton<double>(
          value: dotsBorderWidth,
          items: _kDotsBorderWidthList.map(_itemBuilderDotsDimen).toList(),
          onChanged: (value) {
            setState(() {
              dotsBorderWidth = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsShape() => ListTile(
        title: const Text('Dots shape: '),
        trailing: DropdownButton<BoxShape>(
          value: dotsShape,
          items: BoxShape.values.map(_itemBuilderDotsShape).toList(),
          onChanged: (value) {
            setState(() {
              dotsShape = value!;
            });
          },
        ),
      );

  Widget _buildListTileDotsSpacing() => ListTile(
        title: const Text('Dots spacing: '),
        trailing: DropdownButton<EdgeInsets>(
          value: dotsSpacing,
          items: _kDotsSpacingMap.keys.map(_itemBuilderDotsSpacing).toList(),
          onChanged: (value) {
            setState(() {
              dotsSpacing = value!;
            });
          },
        ),
      );

  DropdownMenuItem<_DotsColor> _itemBuilderDotsColor(_DotsColor value) {
    final text = value.toString().substring(value.toString().indexOf(".") + 1);
    return DropdownMenuItem<_DotsColor>(
      value: value,
      child: Text(text),
    );
  }

  DropdownMenuItem<double> _itemBuilderDotsDimen(double value) =>
      DropdownMenuItem<double>(
        value: value,
        child: Text(value.toString()),
      );

  DropdownMenuItem<BoxShape> _itemBuilderDotsShape(BoxShape value) {
    final text = value.toString().substring(value.toString().indexOf(".") + 1);
    return DropdownMenuItem<BoxShape>(
      value: value,
      child: Text(text),
    );
  }

  DropdownMenuItem<EdgeInsets> _itemBuilderDotsSpacing(String spacingKey) =>
      DropdownMenuItem<EdgeInsets>(
        value: _kDotsSpacingMap[spacingKey],
        child: Text(spacingKey),
      );

  Color _getDotsColor(_DotsColor dotsColor, _DotsColorType dotsColorType) =>
      dotsColor.fold(
        onPrimary: () => _getPrimaryColor(dotsColorType),
        onSecondary: () => linden.colors.secondaryAccent,
        onTertiary: () => linden.colors.primaryAction,
      );

  Color _getPrimaryColor(_DotsColorType dotsColorType) => dotsColorType.fold(
        onGeneral: () => linden.colors.dotsIndicatorColor,
        onActive: () => linden.colors.dotsIndicatorActiveColor,
        onBorder: () => linden.colors.dotsIndicatorBorderColor,
      );
}

extension DotsColorExtension on _DotsColor {
  T fold<T>({
    required T Function() onPrimary,
    required T Function() onSecondary,
    required T Function() onTertiary,
  }) {
    switch (this) {
      case _DotsColor.primary:
        return onPrimary();
      case _DotsColor.secondary:
        return onSecondary();
      case _DotsColor.tertiary:
        return onTertiary();
    }
  }
}

extension DotsColorTypeExtension on _DotsColorType {
  T fold<T>({
    required T Function() onGeneral,
    required T Function() onActive,
    required T Function() onBorder,
  }) {
    switch (this) {
      case _DotsColorType.general:
        return onGeneral();
      case _DotsColorType.active:
        return onActive();
      case _DotsColorType.border:
        return onBorder();
    }
  }
}
