import 'package:booqs_mobile/components/shared/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SharedHero extends StatelessWidget {
  const SharedHero({super.key, required this.tag, required this.url});
  final String tag;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      title: const Text('Image'),
                    ),
                    body: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Hero(
                            // 画面遷移後の Hero
                            tag: tag, // 画面遷移前の tag と共通
                            child: PhotoView(
                              imageProvider: NetworkImage(url),
                            )),
                      ),
                    ),
                  );
                }));
      },
      child: Hero(
          // 画面遷移前の Hero
          tag: tag, // 画面遷移後の tag と共通
          transitionOnUserGestures: true,
          child: SharedCacheNetworkImage(url: url)),
    );
  }
}
