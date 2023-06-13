import 'package:booqs_mobile/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    Widget userName() {
      if (user.premium) {
        return RichText(
            text: TextSpan(children: [
          const WidgetSpan(
            child: FaIcon(
              FontAwesomeIcons.crown,
              size: 30,
              color: Colors.black54,
            ),
          ),
          TextSpan(
              text: ' ${user.name}',
              style: const TextStyle(
                  fontSize: 28.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w800))
        ]));
      } else {
        return Text(
          user.name,
          style: const TextStyle(
              fontSize: 28.0,
              color: Colors.black54,
              fontWeight: FontWeight.w800),
        );
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          // Icon
          // ref： https://github.com/putraxor/flutter-login-ui/blob/master/lib/home_page.dart
          Container(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 72.0,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  imageUrl: '${user.iconImageUrl}',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/not_found_icon.png'),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
          userName(),
          const SizedBox(height: 8),
          Text(
            user.profile ?? '',
            style: const TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
