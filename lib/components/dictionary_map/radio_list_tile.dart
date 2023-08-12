import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/pages/dictionary/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapRadioListTile extends ConsumerWidget {
  const DictionaryMapRadioListTile({super.key, required this.dictionary});
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref: https://api.flutter.dev/flutter/material/RadioListTile-class.html
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: RadioListTile(
        title: Text(dictionary.typeName()),
        value: dictionary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        groupValue: ref.watch(selectedDictionaryProvider),
        onChanged: (Dictionary? value) {
          ref.read(selectedDictionaryProvider.notifier).state = value;
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
      ),
    );
  }
}
