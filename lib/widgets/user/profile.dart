import 'package:booqs_mobile/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // 参考：https://github.com/putraxor/flutter-login-ui/blob/master/lib/home_page.dart
    final CachedNetworkImage image = CachedNetworkImage(
      imageUrl: '${user.iconImageUrl}',
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Image.asset('assets/images/not_found_icon.png'),
      fit: BoxFit.cover,
      width: 200,
      height: 200,
    );
    final icon = Container(
      padding: const EdgeInsets.all(16.0),
      child: CircleAvatar(
        radius: 72.0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: image,
        ),
      ),
    );

    final userName = Text(
      user.name,
      style: const TextStyle(
          fontSize: 28.0, color: Colors.black54, fontWeight: FontWeight.w800),
    );

    final profile = Text(
      user.profile ?? '',
      style: const TextStyle(fontSize: 16.0, color: Colors.black54),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          icon,
          userName,
          const SizedBox(height: 8),
          profile,
        ],
      ),
    );
  }
}
