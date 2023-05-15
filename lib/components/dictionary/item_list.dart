import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryRadioList extends ConsumerStatefulWidget {
  const DictionaryRadioList({Key? key}) : super(key: key);

  @override
  DictionaryRadioListState createState() => DictionaryRadioListState();
}

class DictionaryRadioListState extends ConsumerState<DictionaryRadioList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncMyDictionariesProvider);

    Widget buildListRow(List<Dictionary> dictionaries, int index) {
      final dictionary = dictionaries[index];

      if (index == dictionaries.length - 1) {}

      // ref: https://api.flutter.dev/flutter/material/RadioListTile-class.html
      return RadioListTile(
        title: Text(dictionary.typeName()),
        value: dictionary.id,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        groupValue: ref.watch(dictionaryIdProvider),
        onChanged: (value) {
          final int dictionaryId = int.parse('$value');
          ref.read(dictionaryIdProvider.notifier).state = dictionaryId;
        },
        secondary: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            ref.read(dictionaryProvider.notifier).state = dictionary;
            DictionaryShowPage.push(context, dictionary.id);
          },
        ),
      );
    }

    Widget dictionaryList(data) {
      final List<Dictionary>? dictionaries = data;
      if (dictionaries == null) return Container();

      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => buildListRow(dictionaries, index),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: dictionaries.length,
        padding: const EdgeInsets.only(bottom: 120),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        // 更新したい処理を書く
        ref.invalidate(asyncMyDictionariesProvider);
      },
      child: future.when(
        data: (dictionaries) => dictionaryList(dictionaries),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      ),
    );
  }
}
