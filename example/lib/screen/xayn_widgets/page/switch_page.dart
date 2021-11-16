import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool isSwitchOn = false;
  bool isBtnEnabled = true;

  Widget get verticalSpace => const SizedBox(height: 32);

  @override
  Widget build(BuildContext context) {
    final children = [
      verticalSpace,
      _buildSwitch(),
      verticalSpace,
      _buildSwitchStatus(),
      verticalSpace,
      const Divider(),
      verticalSpace,
      _buildBntEnableSwitcher(),
    ];
    return Column(children: children);
  }

  Widget _buildSwitch() => AppSwitchWidget(
        value: isSwitchOn,
        onToggle: isBtnEnabled ? _onToggle : null,
      );

  Widget _buildSwitchStatus() => Text(
        'isSwitchOn: $isSwitchOn\nisBtnEnabled: $isBtnEnabled',
      );

  Widget _buildBntEnableSwitcher() => CheckboxListTile(
        value: isBtnEnabled,
        onChanged: (checked) {
          setState(() {
            isBtnEnabled = checked!;
          });
        },
        title: const Text('Enable switch'),
      );

  void _onToggle(bool newValue) {
    setState(() {
      isSwitchOn = newValue;
    });
  }
}
