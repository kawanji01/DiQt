import 'package:booqs_mobile/components/heading/medium_green.dart';
import 'package:booqs_mobile/components/sense/form.dart';
import 'package:booqs_mobile/components/sense/form/addition_button.dart';
import 'package:booqs_mobile/data/provider/sense.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordFormSenses extends ConsumerStatefulWidget {
  const WordFormSenses({super.key, required this.word});
  final Word? word;

  @override
  WordFormSensesState createState() => WordFormSensesState();
}

class WordFormSensesState extends ConsumerState<WordFormSenses> {
  // ExpansionTileを閉じた際に発生する、Looking up a deactivated widget's ancestor is unsafe.の解決
  // Looking up a deactivated widget's ancestor is unsafe.
  // エラーメッセージ "Looking up a deactivated widget's ancestor is unsafe." は、典型的にはウィジェットが破棄された後にその親や祖先ウィジェットを参照しようとした場合に表示されます。
  // この問題は Provider や Consumer が原因である可能性が高く、以下の修正が助けになるかもしれません：
  // disposeメソッド内で Provider または Consumer を参照している場合、その参照を dispose メソッド外で行うように変更します。例えば、Provider のインスタンスをフィールド変数として保持し、その変数を dispose メソッドで使用します。
  // ref.read(wordSenseControllerListProvider.notifier)をinitStateメソッドで一度だけ呼び出し、その結果をwordSenseControllerListNotifierフィールドに保持しています。その後、disposeメソッドでwordSenseControllerListNotifier.disposeAllItems()を呼び出しています。
  // これにより、disposeメソッド内でウィジェットツリーを参照する必要がなくなります。これは dispose メソッドがウィジェットが破棄されるときに呼び出され、その時点ではウィジェットツリーは安全に参照できない可能性があるため、良い習慣です。
  late final wordSenseControllerListNotifier =
      ref.read(senseControllerMapListProvider.notifier);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wordSenseControllerListNotifier.initialize(widget.word);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // initStateだけでなく、disposeにもaddPostFrameCallbackを使い、Unhandled Exception: Tried to modify a provider while the widget tree was building.を防ぐ。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wordSenseControllerListNotifier.disposeAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeadingMediumGreen(label: t.words.senses),
      const SenseForm(),
      const SizedBox(
        height: 16,
      ),
      SenseFormAdditionButton(onPressed: () {
        wordSenseControllerListNotifier.add();
      }),
      const SizedBox(
        height: 16,
      ),
    ]);
  }
}
