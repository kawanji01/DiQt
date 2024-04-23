import 'dart:convert';
import 'dart:math';

import 'package:booqs_mobile/components/word_request/item/sense_diff.dart';
import 'package:booqs_mobile/models/word_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestItemSenses extends StatelessWidget {
  const WordRequestItemSenses({super.key, required this.wordRequest});
  final WordRequest wordRequest;

  @override
  Widget build(BuildContext context) {
    final String sensesJson = wordRequest.sensesJson ?? '';
    final String previousSensesJson = wordRequest.previousSensesJson ?? '';
    if (sensesJson == previousSensesJson) {
      return Container();
    }
    final List? sensesMap =
        (sensesJson.isNotEmpty) ? jsonDecode(sensesJson) : null;
    final List? previousSensesMap =
        (previousSensesJson.isNotEmpty) ? jsonDecode(previousSensesJson) : null;
    final int sensesCount = sensesMap?.length ?? 0;
    final int previousSensesCount = previousSensesMap?.length ?? 0;

    List<Widget> senseDiffs() {
      List<Widget> senseDiffs = [];
      for (int i = 0; i < max(sensesCount, previousSensesCount); i++) {
        final Map? sense = (i < sensesCount) ? sensesMap![i] : null;
        final Map? previousSense =
            (i < previousSensesCount) ? previousSensesMap![i] : null;

        senseDiffs.add(WordRequestItemSenseDiff(
            sense: sense, previousSense: previousSense, number: i + 1));
      }
      return senseDiffs;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: senseDiffs(),
    );
  }
}
