import 'package:booqs_mobile/components/dictionary/word_list_view.dart';
import 'package:booqs_mobile/components/markdown/dict_link_select_form.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/dictionary.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:booqs_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownDictLinkScreen extends ConsumerWidget {
  const MarkdownDictLinkScreen(
      {super.key, required this.dictionaryId, required this.keyword});
  final int dictionaryId;
  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 80%の高さで表示する。
    SizeConfig().init(context);
    final double grid = SizeConfig.blockSizeVertical ?? 0;
    final double height = grid * 80;

    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveValues.horizontalMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                ref.watch(asyncDictionaryFamily(dictionaryId)).when(
                    data: (dictionary) {
                      if (dictionary == null) {
                        return Text(t.errors.http_status_404);
                      }
                      return MarkdownDictLinkSelectForm(
                          dictionary: dictionary, keyword: keyword);
                    },
                    loading: () => const LoadingSpinner(),
                    error: (e, s) => Text(e.toString())),
                const SizedBox(height: 24),
                DictionaryWordListView(
                  dictionaryId: dictionaryId,
                  keyword: keyword,
                ),
              ],
            )),
      ),
    );
  }
}
