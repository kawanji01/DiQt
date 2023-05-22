import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/pages/weakness/unsolved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserWeaknessButton extends ConsumerWidget {
  const UserWeaknessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return Container();
    if (user.weaknessesCount == 0) return Container();

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius を効かせると BorderSide が効かなくなる。A borderRadius can only be given for a uniform Border.
        // 解決はできるけど、かなり記述は増えるので保留。ref: https://stackoverflow.com/questions/58812778/a-borderradius-can-only-be-given-for-uniform-borders
        // border: Border(left: BorderSide(color: Colors.green, width: 1)),
        /* border: Border.all(
          width: 1,
          color: Colors.black,
          style: BorderStyle.solid,
        ), */
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 4),
            blurRadius: 6,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: const Color(0x30f010f0),
          onTap: () => WeaknessUnsolvedPage.push(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Colors.green,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    const Text(
                      '苦手な問題',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '${user.unsolvedWeaknessesCount}問',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
