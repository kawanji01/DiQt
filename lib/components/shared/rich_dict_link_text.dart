import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichDictLinkText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final void Function(String keyword)? onLinkTap;
  final bool autoLinkEnabled;

  const RichDictLinkText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    required this.textDirection,
    required this.textAlign,
    this.onLinkTap,
    this.autoLinkEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
    );
    final spans = autoLinkEnabled
        ? _parseTextToSpansWithAutoLink(text, style, onLinkTap)
        : _parseTextToSpans(text, style, onLinkTap);
    return RichText(
      text: TextSpan(children: spans, style: style),
      textDirection: textDirection,
      textAlign: textAlign,
    );
  }

  List<TextSpan> _parseTextToSpans(
      String text, TextStyle style, void Function(String)? onLinkTap) {
    final RegExp exp = RegExp(r'(\[\[.*?\]\])');
    final matches = exp.allMatches(text);

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      // 通常テキスト
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      // リンク部分
      final linkText = match.group(0)!;
      String display, keyword;
      if (linkText.contains('|')) {
        final parts = linkText.substring(2, linkText.length - 2).split('|');
        display = parts[0];
        keyword = parts[1];
      } else {
        display = linkText.substring(2, linkText.length - 2);
        keyword = display;
      }
      spans.add(TextSpan(
        text: display,
        style: style.copyWith(
          color: Colors.green,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onLinkTap != null) onLinkTap(keyword);
          },
      ));
      lastEnd = match.end;
    }
    // 残りのテキスト
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }
    return spans;
  }

  List<TextSpan> _parseTextToSpansWithAutoLink(
      String text, TextStyle style, void Function(String)? onLinkTap) {
    final RegExp exp = RegExp(r'(\[\[.*?\]\])');
    final matches = exp.allMatches(text);
    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      // 通常テキスト部分を単語ごとにリンク化
      if (match.start > lastEnd) {
        final normalText = text.substring(lastEnd, match.start);
        spans.addAll(_autoLinkSpans(normalText, style, onLinkTap));
      }
      // [[...]]記法部分は従来通り
      final linkText = match.group(0)!;
      String display, keyword;
      if (linkText.contains('|')) {
        final parts = linkText.substring(2, linkText.length - 2).split('|');
        display = parts[0];
        keyword = parts[1];
      } else {
        display = linkText.substring(2, linkText.length - 2);
        keyword = display;
      }
      spans.add(TextSpan(
        text: display,
        style: style.copyWith(
          color: Colors.green,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onLinkTap != null) onLinkTap(keyword);
          },
      ));
      lastEnd = match.end;
    }
    // 残りのテキストも単語ごとにリンク化
    if (lastEnd < text.length) {
      final normalText = text.substring(lastEnd);
      spans.addAll(_autoLinkSpans(normalText, style, onLinkTap));
    }
    return spans;
  }

  List<TextSpan> _autoLinkSpans(
      String text, TextStyle style, void Function(String)? onLinkTap) {
    final words = text.split(RegExp(r'(\s+)'));
    final matches = RegExp(r'(\s+)').allMatches(text).toList();
    List<TextSpan> spans = [];
    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      if (word.isNotEmpty) {
        spans.add(TextSpan(
          text: word,
          style: style.copyWith(
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onLinkTap != null) onLinkTap(word);
            },
        ));
      }
      // スペースも追加
      if (i < matches.length) {
        spans.add(TextSpan(text: matches[i].group(0)));
      }
    }
    return spans;
  }
}
