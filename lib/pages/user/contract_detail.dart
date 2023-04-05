import 'package:booqs_mobile/components/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/user/contract_details.dart';
import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserContractDetailsPage extends ConsumerWidget {
  const UserContractDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);

    Widget page(User? user) {
      if (user == null) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 32),
            child: const Text('Please logged in'));
      }
      if (user.premium && user.paidViaNativeApp == false) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 32),
            child: const Text('Webで課金してますやん。'));
      }
      return UserContractDetails(
        user: user,
      );
    }

    // 最終的なアウトプット
    return Scaffold(
      appBar: AppBar(
        title: const Text('ご契約内容'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveValues.horizontalMargin(context)),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: page(user),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
