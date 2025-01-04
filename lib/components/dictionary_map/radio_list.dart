import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/dictionary_map/radio_list_tile.dart';
import 'package:booqs_mobile/data/local/user_info.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/data/remote/dictionaries.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapRadioList extends ConsumerStatefulWidget {
  const DictionaryMapRadioList({super.key});

  @override
  DictionaryMapRadioListState createState() => DictionaryMapRadioListState();
}

class DictionaryMapRadioListState
    extends ConsumerState<DictionaryMapRadioList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 何も選択されていない場合は、最後に選択した辞書を設定
      if (ref.read(selectedDictionaryProvider) == null) {
        _loadLastSelectedDictionary();
      }
    });
    super.initState();
  }

  Future<void> _loadLastSelectedDictionary() async {
    final int? selectedDictionaryId =
        await LocalUserInfo.selectedDictionaryId();
    if (selectedDictionaryId == null) return;
    final Map resMap = await RemoteDictionaries.show(selectedDictionaryId);
    if (ErrorHandler.isErrorMap(resMap)) {
      if (!mounted) return;
      return ErrorHandler.showErrorSnackBar(context, resMap);
    }
    final Dictionary dictionary = Dictionary.fromJson(resMap['dictionary']);
    ref.read(selectedDictionaryProvider.notifier).state = dictionary;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        // 更新したい処理を書く
        ref.invalidate(asyncMyDictionariesProvider);
      },
      child: ref.watch(asyncMyDictionariesProvider).when(
            data: (List<Dictionary>? dictionaries) {
              if (dictionaries == null) {
                // リロードボタンを表示
                return InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      ref.invalidate(asyncMyDictionariesProvider);
                    },
                    child: SmallOutlineGreenButton(
                        label: t.shared.reload, icon: Icons.refresh));
              }
              // ラジオボタンを表示
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final dictionary = dictionaries[index];
                  return DictionaryMapRadioListTile(
                    dictionary: dictionary,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: dictionaries.length,
                padding: const EdgeInsets.only(top: 48, bottom: 120),
              );
            },
            error: (err, stack) => Text('Error: $err'),
            loading: () => const LoadingSpinner(),
          ),
    );
  }
}
