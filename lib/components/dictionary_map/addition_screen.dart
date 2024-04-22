import 'package:booqs_mobile/components/button/medium_green_button.dart';
import 'package:booqs_mobile/components/dictionary_map/addition_list_view.dart';
import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/data/provider/dictionary_map.dart';
import 'package:booqs_mobile/data/remote/dictionary_maps.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryMapAdditionScreen extends ConsumerStatefulWidget {
  const DictionaryMapAdditionScreen({super.key});

  @override
  DictionaryMapAdditionScreenState createState() =>
      DictionaryMapAdditionScreenState();
}

class DictionaryMapAdditionScreenState
    extends ConsumerState<DictionaryMapAdditionScreen> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    Future<void> update() async {
      setState(() => _isRequesting = true);

      final List<int> dictionaryIdList =
          ref.watch(additionDictionaryIdsProvider);
      // 画面全体にローディングを表示
      EasyLoading.show(status: 'loading...');
      final Map? resMap = await RemoteDictionaryMaps.add(dictionaryIdList);
      EasyLoading.dismiss();
      setState(() => _isRequesting = false);
      if (!context.mounted) return;

      Navigator.of(context).pop();

      if (resMap == null) {
        const snackBar = SnackBar(content: Text('Error'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ref.read(additionDictionaryIdsProvider.notifier).state = [];
        final snackBar = SnackBar(content: Text('${resMap['message']}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // My辞書を更新する
        ref.invalidate(asyncMyDictionariesProvider);
      }
    }

    Widget column() {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          HeadingMediumGreen(
              label: t.dictionaryMaps.select_dictionaries_to_use,
              icon: Icons.add),
          const SizedBox(
            height: 24,
          ),
          const DictionaryMapAdditionListView(),
          const SizedBox(
            height: 24,
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
                child: MediumGreenButton(
                  label: t.dictionaryMaps.add,
                  icon: Icons.add,
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
