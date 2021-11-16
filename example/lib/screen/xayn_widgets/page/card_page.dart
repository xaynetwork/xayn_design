import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

enum _ElevationOption {
  small,
  middle,
  defaultOne,
}

enum _RadiusOption {
  small,
  defaultOne,
  custom,
}

enum _PaddingOption {
  zero,
  defaultOne,
  custom,
}

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  Widget get verticalSpace => const SizedBox(height: 32);

  Linden get linden => UnterDenLinden.getLinden(context);

  bool isHighlighted = false;

  _ElevationOption elevationOption = _ElevationOption.defaultOne;
  _RadiusOption radiusOption = _RadiusOption.defaultOne;
  _PaddingOption paddingOption = _PaddingOption.defaultOne;

  @override
  Widget build(BuildContext context) {
    final children = [
      verticalSpace,
      _buildCard(),
      verticalSpace,
      const Divider(),
      _buildParams(),
    ];
    return Column(children: children);
  }

  Widget _buildCard() {
    final image = SvgPicture.asset(
      linden.assets.illustrations.brainyEnabled,
      width: 42,
      height: 42,
    );

    late final double? elevation;
    switch (elevationOption) {
      case _ElevationOption.small:
        elevation = 4;
        break;
      case _ElevationOption.middle:
        elevation = 16;
        break;
      case _ElevationOption.defaultOne:
        elevation = null;
        break;
    }

    late final BorderRadius? radius;
    switch (radiusOption) {
      case _RadiusOption.small:
        radius = const BorderRadius.all(Radius.circular(4));
        break;
      case _RadiusOption.defaultOne:
        radius = null;
        break;
      case _RadiusOption.custom:
        radius = const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(16),
          bottomLeft: Radius.elliptical(15, 6),
          bottomRight: Radius.elliptical(6, 24),
        );
        break;
    }

    late final EdgeInsets? padding;
    switch (paddingOption) {
      case _PaddingOption.zero:
        padding = EdgeInsets.zero;
        break;
      case _PaddingOption.defaultOne:
        padding = null;
        break;
      case _PaddingOption.custom:
        padding = const EdgeInsets.fromLTRB(16, 4, 24, 32);
        break;
    }
    return AppCardWidget(
      child: image,
      isHighlighted: isHighlighted,
      elevation: elevation,
      borderRadius: radius,
      contentPadding: padding,
    );
  }

  Widget _buildParams() {
    final children = <Widget>[
      _buildIsHighlighted(),
      _buildElevationChange(),
      _buildRadiusChange(),
      _buildPaddingChange(),
    ];
    final column = Column(children: children);

    return SingleChildScrollView(child: column);
  }

  Widget _buildIsHighlighted() => CheckboxListTile(
        value: isHighlighted,
        onChanged: (checked) {
          setState(() {
            isHighlighted = checked!;
          });
        },
        title: const Text('is highlighted'),
      );

  Widget _buildElevationChange() {
    DropdownMenuItem<_ElevationOption> itemBuilder(_ElevationOption value) {
      final text =
          value.toString().substring(value.toString().indexOf(".") + 1);
      return DropdownMenuItem<_ElevationOption>(
        value: value,
        child: Text(text),
      );
    }

    final dropDown = DropdownButton<_ElevationOption>(
      value: elevationOption,
      items: _ElevationOption.values.map(itemBuilder).toList(),
      onChanged: (_ElevationOption? option) {
        setState(() {
          elevationOption = option!;
        });
      },
    );
    return ListTile(
      title: const Text('elevation option'),
      trailing: dropDown,
    );
  }

  Widget _buildRadiusChange() {
    DropdownMenuItem<_RadiusOption> itemBuilder(_RadiusOption value) {
      final text =
          value.toString().substring(value.toString().indexOf(".") + 1);
      return DropdownMenuItem<_RadiusOption>(
        value: value,
        child: Text(text),
      );
    }

    final dropDown = DropdownButton<_RadiusOption>(
      value: radiusOption,
      items: _RadiusOption.values.map(itemBuilder).toList(),
      onChanged: (_RadiusOption? option) {
        setState(() {
          radiusOption = option!;
        });
      },
    );
    return ListTile(
      title: const Text('radius option'),
      trailing: dropDown,
    );
  }

  Widget _buildPaddingChange() {
    DropdownMenuItem<_PaddingOption> itemBuilder(_PaddingOption value) {
      final text =
          value.toString().substring(value.toString().indexOf(".") + 1);
      return DropdownMenuItem<_PaddingOption>(
        value: value,
        child: Text(text),
      );
    }

    final dropDown = DropdownButton<_PaddingOption>(
      value: paddingOption,
      items: _PaddingOption.values.map(itemBuilder).toList(),
      onChanged: (_PaddingOption? option) {
        setState(() {
          paddingOption = option!;
        });
      },
    );
    return ListTile(
      title: const Text('content padding option'),
      trailing: dropDown,
    );
  }
}
