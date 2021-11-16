import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  final btnText = 'btn';

  Linden get linden => UnterDenLinden.getLinden(context);

  String get svgIconPath => linden.assets.icons.heart;

  Widget get verticalSpace => const SizedBox(height: 32);

  ButtonColor color = ButtonColor.primary;
  bool withText = false;
  bool withIcon = false;
  bool withCustomWidget = false;
  bool circleIcon = false;
  bool clickEnabled = true;
  bool minSizeEqual = false;

  @override
  void initState() {
    _checkButtonTypeCheckboxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      verticalSpace,
      _buildRaisedButton(),
      verticalSpace,
      const Divider(),
      _buildParams(),
    ];
    return Column(children: children);
  }

  void _onPressed() {}

  Widget _buildRaisedButton() {
    if (withCustomWidget) {
      return AppRaisedButton(
        child: SvgPicture.asset(linden.assets.illustrations.brainyEnabled),
        onPressed: clickEnabled ? _onPressed : null,
        color: color,
        minSizeEqual: minSizeEqual,
      );
    }
    if (withIcon && withText) {
      return AppRaisedButton.textWithIcon(
        onPressed: clickEnabled ? _onPressed : null,
        text: btnText,
        svgIconPath: svgIconPath,
        color: color,
        minSizeEqual: minSizeEqual,
      );
    }
    if (withText) {
      return AppRaisedButton.text(
        onPressed: clickEnabled ? _onPressed : null,
        text: btnText,
        color: color,
        minSizeEqual: minSizeEqual,
      );
    }
    return AppRaisedButton.icon(
      onPressed: clickEnabled ? _onPressed : null,
      svgIconPath: svgIconPath,
      circle: circleIcon,
      color: color,
    );
  }

  Widget _buildParams() {
    final children = [
      _buildWithText(),
      _buildWithIcon(),
      _buildCircleIcon(),
      _buildWithCustomWidget(),
      const Divider(),
      _buildClickEnable(),
      _buildMinSizeEqual(),
      const Divider(),
      _buildColorChange(),
    ];
    final column = Column(children: children);

    return SingleChildScrollView(child: column);
  }

  Widget _buildWithIcon() => CheckboxListTile(
        value: withIcon,
        onChanged: (checked) {
          setState(() {
            withIcon = checked!;
            if (withIcon && withCustomWidget) {
              withCustomWidget = false;
            }
            _checkButtonTypeCheckboxes();
          });
        },
        title: const Text('with icon'),
      );

  Widget _buildWithText() => CheckboxListTile(
        value: withText,
        onChanged: (checked) {
          setState(() {
            withText = checked!;
            if (withText && withCustomWidget) {
              withCustomWidget = false;
            }
            _checkButtonTypeCheckboxes();
          });
        },
        title: const Text('with text'),
      );

  Widget _buildWithCustomWidget() => CheckboxListTile(
        value: withCustomWidget,
        onChanged: (checked) {
          setState(() {
            withCustomWidget = checked!;
            if (withCustomWidget && (withIcon || withText)) {
              withIcon = false;
              withText = false;
            }
            _checkButtonTypeCheckboxes();
          });
        },
        title: const Text('with custom widget'),
      );

  Widget _buildCircleIcon() {
    final isDisable = !withIcon || withText || withCustomWidget;
    final onChanged = isDisable
        ? null
        : (checked) {
            setState(() {
              circleIcon = checked!;
              _checkButtonTypeCheckboxes();
            });
          };
    final tile = CheckboxListTile(
      value: circleIcon,
      onChanged: onChanged,
      title: const Text('circle (only for icon)'),
    );
    return Opacity(opacity: isDisable ? 0.5 : 1, child: tile);
  }

  Widget _buildClickEnable() => CheckboxListTile(
        value: clickEnabled,
        onChanged: (checked) {
          setState(() {
            clickEnabled = checked!;
          });
        },
        title: const Text('Click enable'),
      );

  Widget _buildMinSizeEqual() => CheckboxListTile(
        value: minSizeEqual,
        onChanged: (checked) {
          setState(() {
            minSizeEqual = checked!;
          });
        },
        title: const Text('Min size equal'),
      );

  Widget _buildColorChange() {
    DropdownMenuItem<ButtonColor> itemBuilder(ButtonColor value) {
      final text =
          value.toString().substring(value.toString().indexOf(".") + 1);
      return DropdownMenuItem<ButtonColor>(
        value: value,
        child: Text(text),
      );
    }

    final dropDown = DropdownButton<ButtonColor>(
      value: color,
      items: ButtonColor.values.map(itemBuilder).toList(),
      onChanged: (ButtonColor? color) {
        setState(() {
          this.color = color!;
        });
      },
    );
    return ListTile(
      title: const Text('Button color'),
      trailing: dropDown,
    );
  }

  void _checkButtonTypeCheckboxes() {
    if (!withCustomWidget && !withText && !withIcon) {
      withText = true;
    }
  }
}
