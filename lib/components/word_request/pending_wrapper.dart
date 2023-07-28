import 'package:booqs_mobile/notifications/closing_pending_request.dart';
import 'package:flutter/widgets.dart';

class WordRequestPendingWrapper extends StatefulWidget {
  const WordRequestPendingWrapper({super.key, required this.item});
  final Widget item;

  @override
  State<WordRequestPendingWrapper> createState() =>
      WordRequestPendingWrapperState();
}

class WordRequestPendingWrapperState extends State<WordRequestPendingWrapper> {
  bool _isVisible = true;
  bool _isOpaque = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ClosingPendingRequestNotification>(
      onNotification: (notification) {
        // setStateするとともにプロバイダーも更新してonEndで利用できるようにする
        setState(() {
          _isOpaque = false;
        });
        return true;
      },
      // FadeOutで問題を隠す & 高さも消失させる ref: https://stackoverflow.com/questions/58493886/animated-opacity-and-hiding-the-widget-so-its-not-clickable
      child: AnimatedOpacity(
        opacity: _isOpaque ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        onEnd: () {
          if (_isOpaque == false) {
            setState(() {
              _isVisible = false;
            });
          }
        },
        // 必ずコンテンツは外から渡す。
        // そうしないと、コンテンツが解かれて消えるまでにコンテンツがリビルドされて、選択肢が一瞬ランダムに表示されるなど不細工なことになる。ref: https://qiita.com/chooyan_eng/items/ec11f6dcf714f7a2fa3d
        child: Visibility(
          visible: _isVisible,
          child: widget.item,
        ),
      ),
    );
  }
}
