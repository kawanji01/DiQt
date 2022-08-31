import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/widgets/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryRadioList extends ConsumerStatefulWidget {
  const DictionaryRadioList({Key? key}) : super(key: key);

  @override
  _DictionaryRadioListState createState() => _DictionaryRadioListState();
}

class _DictionaryRadioListState extends ConsumerState<DictionaryRadioList> {
  @override
  void initState() {
    super.initState();
    //ref.refresh(asyncDictionariesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncDictionariesProvider);

    Widget _buildListRow(List<Dictionary> dictionaries, int index) {
      final dictionary = dictionaries[index];

      final iconButton = IconButton(
        icon: const Icon(Icons.arrow_forward_ios_rounded),
        onPressed: () {
          ref.read(dictionaryProvider.notifier).state = dictionary;
          DictionaryShowPage.push(context, dictionary.id);
        },
      );
      // ref: https://api.flutter.dev/flutter/material/RadioListTile-class.html
      return RadioListTile(
        title: Text(dictionary.title),
        value: dictionary.id,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        groupValue: ref.watch(dictionaryIdProvider),
        onChanged: (value) {
          final int dictionaryId = int.parse('$value');
          ref.read(dictionaryIdProvider.notifier).state = dictionaryId;
        },
        secondary: iconButton,
      );
    }

    Widget _dictionaryList(data) {
      final List<Dictionary>? dictionaries = data;
      if (dictionaries == null) return Container();

      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildListRow(dictionaries, index),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: dictionaries.length,
      );
    }

    return future.when(
      data: (dictionaries) => _dictionaryList(dictionaries),
      error: (err, stack) => Text('Error: $err'),
      loading: () => const LoadingSpinner(),
    );
  }
}
