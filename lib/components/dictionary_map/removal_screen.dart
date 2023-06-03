import 'package:booqs_mobile/components/button/medium_red_button.dart';
import 'package:booqs_mobile/components/dictionary_map/removal_list_item.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/data/remote/dictionary_maps.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapRemovalScreen extends ConsumerStatefulWidget {
  const DictionaryMapRemovalScreen({super.key});

  @override
  DictionaryMapRemovalScreenState createState() =>
      DictionaryMapRemovalScreenState();
}

class DictionaryMapRemovalScreenState
    extends ConsumerState<DictionaryMapRemovalScreen> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    Future<void> update() async {
      setState(() => _isRequesting = true);

      final List<int> dictionaryIdList =
          ref.watch(removalDictionaryIdsProvider);
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteDictionaryMaps.remove(dictionaryIdList);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!mounted) return;

      Navigator.of(context).pop();

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('Error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ref.read(removalDictionaryIdsProvider.notifier).state = [];
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // My辞書を更新する
        ref.invalidate(asyncMyDictionariesProvider);
      }
    }

    List<Widget> removalListView(List<Dictionary>? dictionaries) {
      // dictionariesがnullまたは空の場合、'No dictionaries found'と表示するWidgetを返す
      if (dictionaries == null || dictionaries.isEmpty) {
        return [const Text('No dictionaries found')];
      }
      // dictionariesがnullでない場合、それぞれの要素に対してDictionaryMapRemovalListItemを作成する
      return dictionaries
          .map((element) => DictionaryMapRemovalListItem(dictionary: element))
          .toList();
    }

    Widget column() {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          HeadingMediumGreen(
              label: '${t['dictionaryMaps.select_dictionaries_to_remove']}',
              icon: Icons.remove),
          const SizedBox(
            height: 24,
          ),
          ref.watch(asyncMyDictionariesProvider).when(
                data: (data) => Column(
                  children: removalListView(data),
                ),
                error: (err, stack) => Text('Error: $err'),
                loading: () => const LoadingSpinner(),
              ),
          const SizedBox(
            height: 140,
          ),
        ],
      );
    }

    Widget submitButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          padding: const EdgeInsets.only(bottom: 32),
          color: Colors.white,
          child: SizedBox(
              height: 56,
              child: InkWell(
                onTap: _isRequesting
                    ? null
                    : () async {
                        update();
                      },
                child: MediumRedButton(
                  label: t.dictionaryMaps.remove,
                  icon: Icons.remove,
                  fontSize: 18,
                ),
              )),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: ResponsiveValues.dialogHeight(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveValues.horizontalMargin(context)),
              child: column(),
            ),
          ),
          submitButton(),
        ],
      ),
    );
  }
}
