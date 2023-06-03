import 'package:firebase_analytics/firebase_analytics.dart';

// FirebaseAnalyticsのラッパーを、シングルトンクラスで定義する。
// シングルトンクラスのメリット
// 1, 一貫性：シングルトンクラスは、アプリケーション全体で単一のインスタンスを保証します。これにより、異なる部分のコード間で一貫性を維持するのが容易になります。
// 2, リソース節約：インスタンスが一つしか存在しないため、メモリの使用量を削減できます。これは特に、そのクラスのインスタンスが大量のリソースを消費する場合に有益です。
// 3, グローバルアクセスポイント：シングルトンはその唯一のインスタンスへのグローバルアクセスポイントを提供します。これは、グローバル変数を使うことの多くのリスクを避けつつ、同様の利便性を提供します。
// 4, 制御された共有リソースのアクセス：データベース接続、ファイルシステムへのアクセスなど、共有リソースへのアクセスを制御するのに役立ちます。
// シングルトンクラスのデメリット
// 1, テストの難易度が上がる
// 2, スレッドセーフを確保する必要がある
// 3, 状態管理が複雑になる
// シングルトンパターンは、特に、資源を大量に消費するか、その状態がアプリケーション全体で共有されるべきもので有効らしい。
// analytics は、 mainでの初期化とコンバージョンページでログを送るくらいにしか使わないし、テストもしないので、シングルトンでも良さそう？
class AnalyticsService {
  // 非null制約を満たすためのlateキーワード。
  // late キーワードは、変数が必ず初期化されることが保証されている場合に用いることができる。
  // この場合には _singleton が生成されるときに firebaseAnalyticsInstance が初期化されるため、late キーワードを使用することが適切。
  // lateが使われる目的
  // 1. 遅延初期化（Lazy Initialization）: Dart では、変数は宣言と同時に初期化する必要があります。しかし、初期化にコストがかかる場合や初期化が必要になるまで待ちたい場合には、遅延初期化を行いたいと思うことがあります。late キーワードを使用すると、変数の初期化を遅らせることができます。これは変数が初めてアクセスされたときに初期化されます。
  // 2, 初期化前の非nullフィールドを許可する: Dart の Null Safety 機能は、全ての変数が非nullであることをデフォルトとします。しかし、いくつかの変数は初期化するまで null であり、その後で非nullになります。例えば、Flutter の initState メソッドや Dart の Factory コンストラクタなどがこれに該当します。このような場合、late キーワードを使用して初期化前の null を許容し、初期化後は非nullとして扱うことができます。
  // 今回の場合は2が目的。
  // "firebaseAnalyticsInstance" は、"AnalyticsService._()"（コンストラクタ） で初期化されるまではnullを許容するので、lateキーワードが適切。
  late final FirebaseAnalytics firebaseAnalyticsInstance;

  // AnalyticsService の 名前付きのコンストラクタ。
  // コンストラクタは、クラスからオブジェクトをインスタンス化するときに自動的に呼び出される処理のこと。
  // 通常コンストラクタは、 AnalyticsService() のように"クラス名()"で定義されている。
  // AnalyticsService._() は名前付きのコンストラクタで、名前に"_"がつくことでプレイベートコンストラクタとなる。
  // プレイベートコンストラクタは、クラス外部からの直接的なインスタンス化を制限している。そのため、このコンストラクタはクラス内部からしか呼び出せない。
  // つまり、クラスの外で "AnalyticsService._()" のように実行することはできない。
  AnalyticsService._() {
    firebaseAnalyticsInstance = FirebaseAnalytics.instance;
  }
  // static: このキーワードは、変数がクラスレベルで定義されることを意味する。つまり、この変数は AnalyticsService クラスの全てのインスタンスで共有される。
  static final _singleton = AnalyticsService._();

  // 通常のコンストラクタ（ AnalyticsService() ）の上書き。
  // factoryキーワードは、コンストラクタを定義する際に使用される。
  // factoryキーワードを使用すると、通常のコンストラクタとは異なり、コンストラクタは新しいインスタンスを必ず生成するのではなく、既存のインスタンスを返すか、あるいはサブタイプのインスタンスを返すことができる。
  // 以下は、通常のコンストラクタである AnalyticsService() を 同名のファクトリメソッドによって上書きすることによって、
  // AnalyticsService の新しいインスタンスを作成しようとするたびに、既存のシングルトンインスタンスである _singleton を返すようにしている。
  // これによって AnalyticsService().setCurrentScreen() などを行ったときに、新しいインスタンスが生成されなくなる
  // この処理によってシングルトンを実現している。
  factory AnalyticsService() => _singleton;

  // mainに設置して計測を開始する
  Future<void> logBeginCheckout() async {
    firebaseAnalyticsInstance.logBeginCheckout();
  }

  // 測定したい画面のinitStateなどで以下のメソッドを呼び出すことで、そのページをanalyticsに記録する。
  Future<void> setCurrentScreen(String screenName) async {
    await firebaseAnalyticsInstance.setCurrentScreen(screenName: screenName);
  }
}
