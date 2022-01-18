import 'package:flutter/material.dart';
import 'package:xayn_design/xayn_design.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({Key? key}) : super(key: key);

  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  Linden get linden => UnterDenLinden.getLinden(context);

  Widget get verticalSpace => const SizedBox(height: 32);

  @override
  Widget build(BuildContext context) {
    final children = [
      verticalSpace,
      _buildButtons(),
      verticalSpace,
    ];
    return Column(children: children);
  }

  Widget _buildButtons() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildShowSheetButton(),
          _buildScrollableSheetButton(),
        ],
      );

  Widget _buildShowSheetButton() => AppRaisedButton.text(
        text: 'Show bottom sheet',
        onPressed: () => showAppBottomSheet(
          context,
          builder: (_) => const ShortBottomSheet(),
        ),
      );

  Widget _buildScrollableSheetButton() => AppRaisedButton.text(
        text: 'Show scrollable bottom sheet',
        onPressed: () => showAppBottomSheet(
          context,
          builder: (_) => const LongBottomSheet(),
        ),
      );
}

class ShortBottomSheet extends BottomSheetBase {
  const ShortBottomSheet({Key? key})
      : super(key: key, body: const ShortBottomSheetBody());
}

class ShortBottomSheetBody extends StatelessWidget {
  const ShortBottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(50),
        child: Text('Bottom Sheet Body'),
      );
}

class LongBottomSheet extends BottomSheetBase {
  const LongBottomSheet({Key? key})
      : super(key: key, body: const LongBottomSheetBody());
}

class LongBottomSheetBody extends StatelessWidget with BottomSheetBodyMixin {
  const LongBottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: ListView.builder(
          controller: getScrollController(context),
          itemCount: 100,
          itemBuilder: (_, int index) => Text('Item $index'),
        ),
      );
}
