import 'package:flutter_riverpod/flutter_riverpod.dart';

// word, sentence, quizの編集画面で、他の画面に遷移させないためのフラグ。
// 編集画面に遷移した場合は、onEditを実行し、フラグをtrueにし、その他の編集画面には遷移できないようにする。
// 編集完了（作成・更新・削除）した場合は、offEditを実行して、画面遷移を許可する。
class SharedEditingContentState extends StateNotifier<bool> {
  SharedEditingContentState() : super(false);

  void onEdit() {
    state = true;
  }

  void offEdit() {
    state = false;
  }
}

final sharedEditingContentProvider =
    StateNotifierProvider<SharedEditingContentState, bool>(
        (ref) => SharedEditingContentState());
