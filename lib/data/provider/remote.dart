import 'package:booqs_mobile/data/remote/sessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 依存関係注入（Dependency Injection、DI）を使用して、
// RemoteSessionsのメソッド（APIへのリクエスト）をmock化できるようにするためのProvider。
// test/widget/login_form_testを見るとわかりやすい。
final remoteSessionsProvider = Provider<RemoteSessions>((ref) {
  return RemoteSessions();
});
