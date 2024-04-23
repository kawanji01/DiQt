import 'package:booqs_mobile/components/sense/form/field.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SenseForm extends ConsumerWidget {
  const SenseForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, TextEditingController>>? senseControllerMapList =
        ref.watch(senseControllerMapListProvider);
    final int sensesCount = senseControllerMapList?.length ?? 0;
    if (senseControllerMapList == null || sensesCount == 0) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sensesCount; i++)
          SenseFormField(
              senseControllerMap: senseControllerMapList[i],
              number: i + 1,
              last: i == senseControllerMapList.length - 1)
      ],
    );
  }
}
