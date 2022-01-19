import 'package:flutter/material.dart';

Text getHighlightedText({
  required String text,
  required String highlight,
  TextStyle? highlightTextStyle,
  TextStyle? labelTextStyle,
}) {
  final spans = <TextSpan>[];
  var start = 0;
  int indexOfHighlight;

  noHighlight() => spans.add(_normalSpan(
        text.substring(start),
        labelTextStyle,
      ));

  textBeforeHighlight(int indexOfHighlight) => spans.add(_normalSpan(
        text.substring(start, indexOfHighlight),
        labelTextStyle,
      ));

  highlightText(int indexOfHighlight) => spans.add(_highlightSpan(
        text.substring(indexOfHighlight, start),
        highlightTextStyle,
      ));

  do {
    indexOfHighlight = text.indexOf(highlight, start);

    if (indexOfHighlight < 0) {
      noHighlight();
      break;
    }

    if (indexOfHighlight > start) textBeforeHighlight(indexOfHighlight);

    start = indexOfHighlight + highlight.length;
    highlightText(indexOfHighlight);
  } while (true);

  return Text.rich(TextSpan(children: spans));
}

TextSpan _highlightSpan(String content, TextStyle? highlightedTextStyle) =>
    TextSpan(text: content, style: highlightedTextStyle);

TextSpan _normalSpan(String content, TextStyle? labelTextStyle) =>
    TextSpan(text: content, style: labelTextStyle);
