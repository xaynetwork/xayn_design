import 'package:example/utils/tooltip_keys.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class TooltipPage extends StatefulWidget {
  const TooltipPage({Key? key}) : super(key: key);

  @override
  State<TooltipPage> createState() => _TooltipPageState();
}

class _TooltipPageState extends State<TooltipPage> with TooltipStateMixin {
  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _registerDynamicTooltips(linden);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSimpleTooltipBtn(),
        _buildTooltipWithIcon(),
        const SizedBox(height: 30),
        _buildAnchorWidget(linden),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  void _registerDynamicTooltips(Linden linden) {
    registerTooltip(
      key: TooltipKeys.withIcon,
      params: TooltipParams(
        label: 'Undo action',
        builder: (_) => TextualNotification(
          icon: linden.assets.icons.undo,
          onTap: (parameters) {
            //ignore: avoid_print
            print('undo action clicked');
          },
        ),
      ),
    );
  }

  Widget _buildAnchorWidget(Linden linden) => TooltipContextProvider(
      child:
          Text('This is tooltip anchor widget', style: linden.styles.mStyle));

  Widget _buildSimpleTooltipBtn() => _buildButton('Show simple tooltip', () {
        showTooltip(TooltipKeys.simple);
      });

  Widget _buildTooltipWithIcon() => _buildButton('Show tooltip with Icon', () {
        showTooltip(TooltipKeys.withIcon);
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );
}
