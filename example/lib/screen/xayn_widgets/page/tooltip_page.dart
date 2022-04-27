import 'package:example/utils/tooltip_messages.dart';
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSimpleTooltipBtn(),
        _buildTooltipWithIcon(),
        _buildTooltipWith2LinesText(),
        _buildTooltipWithLongText(),
        const SizedBox(height: 30),
        _buildAnchorWidget(linden),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Widget _buildAnchorWidget(Linden linden) => TooltipContextProvider(
      child:
          Text('This is tooltip anchor widget', style: linden.styles.mStyle));

  Widget _buildSimpleTooltipBtn() => _buildButton('Show simple tooltip', () {
        showTooltip(TooltipMessages.simple());
      });

  Widget _buildTooltipWithIcon() => _buildButton('Show tooltip with Icon', () {
        showTooltip(TooltipMessages.withIcon(context));
      });

  Widget _buildTooltipWith2LinesText() =>
      _buildButton('Show 2 lines tooltip', () {
        showTooltip(TooltipMessages.twoLines());
      });

  Widget _buildTooltipWithLongText() =>
      _buildButton('Show long text tooltip', () {
        showTooltip(TooltipMessages.longText(context));
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );
}
