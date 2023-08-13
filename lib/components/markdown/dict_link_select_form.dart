import 'package:booqs_mobile/components/button/small_outline_green_button.dart';
import 'package:booqs_mobile/components/markdown/dict_link_screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownDictLinkSelectForm extends ConsumerStatefulWidget {
  const MarkdownDictLinkSelectForm(
      {super.key, required this.dictionary, required this.keyword});
  final Dictionary dictionary;
  final String keyword;

  @override
  ConsumerState<MarkdownDictLinkSelectForm> createState() =>
      MarkdownDictLinkSelectFormState();
}

class MarkdownDictLinkSelectFormState
    extends ConsumerState<MarkdownDictLinkSelectForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87);

    return ref.watch(asyncMyDictionariesProvider).when(
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
            // dropDownをDictionaryにしてしまうと、asyncMyDictionariesProviderで取得したdictionaryとwidget.dictionaryに微妙な違いが発生して、きちんとvalueとして認識してくれない場合があるのでintにしておく。
            final List<int> dictionaryIds =
                dictionaries.map((e) => e.id).toList();
            final bool containsDictionary =
                dictionaryIds.contains(widget.dictionary.id);
            // ラジオボタンを表示
            return Container(
              margin: const EdgeInsets.only(top: 24),
              height: 48,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black87)),
              child: DropdownButton<int>(
                isExpanded: true,
                value: containsDictionary ? widget.dictionary.id : null,
                hint: Text(widget.dictionary.typeName(), style: titleStyle),
                iconSize: 24,
                elevation: 16,
                onChanged: (int? newValue) {
                  if (newValue == null) return;
                  // 前の検索モーダルを閉じる。
                  Navigator.pop(context);
                  // 辞書の検索
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    builder: (context) => MarkdownDictLinkScreen(
                      dictionaryId: newValue,
                      keyword: widget.keyword,
                    ),
                  );
                },
                items: dictionaryIds.map<DropdownMenuItem<int>>((int value) {
                  final Dictionary dictionary =
                      dictionaries.firstWhere((e) => e.id == value);
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(dictionary.typeName(), style: titleStyle),
                  );
                }).toList(),
              ),
            );
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const LoadingSpinner(),
        );
  }
}