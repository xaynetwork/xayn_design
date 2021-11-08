import 'package:example/utils/tooltip_keys.dart';
import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class WidgetsScreen extends StatefulWidget {
  static const routeName = '/widgets';

  const WidgetsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen> with TooltipStateMixin {
  Linden get linden => UnterDenLinden.getLinden(context);

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _registerDynamicTooltips();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _buildSimpleTooltipBtn(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xayn widgets'),
      ),
      body: content,
      floatingActionButton: _buildUndoButton(),
    );
  }

  void _registerDynamicTooltips() {
    final linden = this.linden;
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

  Widget _buildUndoButton() {
    final fab = FloatingActionButton(
      onPressed: () {
        showTooltip(TooltipKeys.withIcon);
      },
      tooltip: 'Show undo',
      child: SvgPicture.asset(
        linden.assets.icons.undo,
        color: linden.colors.brightIcon,
      ),
    );
    return TooltipContextProvider(child: fab);
  }

  Widget _buildSimpleTooltipBtn() => _buildButton('Show simple tooltip', () {
        showTooltip(TooltipKeys.simple);
      });

  Widget _buildButton(String text, VoidCallback onPressed) => Center(
        child: ElevatedButton(onPressed: onPressed, child: Text(text)),
      );
}
