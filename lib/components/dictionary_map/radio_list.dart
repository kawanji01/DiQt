import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapRadioList extends ConsumerStatefulWidget {
  const DictionaryMapRadioList({Key? key}) : super(key: key);

  @override
  DictionaryMapRadioListState createState() => DictionaryMapRadioListState();
}

class DictionaryMapRadioListState
    extends ConsumerState<DictionaryMapRadioList> {
  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    // 何も選択されていない場合は、一番上の辞書を自動選択
    //   if (ref.watch(selectedDictionaryProvider) == null) {
    //     _restoreLastSelected();
    //  }
    //});

    super.initState();
  }

  // Future<void> _restoreLastSelected() async {
  //  final Dictionary? dictionary = ref.refresh(selectedDictionaryProvider);
  //  ref.read(selectedDictionaryProvider.notifier).state = dictionary;
  //}

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
        groupValue:
            ref.watch(selectedDictionaryProvider.select((value) => value?.id)),
        onChanged: (value) {
          ref.read(selectedDictionaryProvider.notifier).state = dictionary;
          // アプリ再起動時に選択し直さなくても良いように、localStorageに選択した辞書情報を保存しておく。
          LocalUserInfo.writeSelectedDictionaryId(dictionary.id);
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

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        // 更新したい処理を書く
        ref.invalidate(asyncMyDictionariesProvider);
      },
      child: future.when(
        data: (List<Dictionary>? dictionaries) {
          if (dictionaries == null) return Container();

          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => buildListRow(dictionaries, index),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: dictionaries.length,
            padding: const EdgeInsets.only(bottom: 120),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const LoadingSpinner(),
      ),
    );
  }
}