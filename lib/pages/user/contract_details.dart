import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/purchase/contract_details_screen.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/data/provider/purchase.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserContractDetailsPage extends ConsumerStatefulWidget {
  const UserContractDetailsPage({Key? key}) : super(key: key);
  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(userContractDetailsPage);
  }

  @override
  UserContractDetailsPageState createState() => UserContractDetailsPageState();
}

class UserContractDetailsPageState
    extends ConsumerState<UserContractDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Unhandled Exception: setState() or markNeedsBuild() called during build.を防ぐために、
    // すべてのビルドが終わってからrefreshする。
    // ref: https://zuma-lab.com/posts/flutter-troubleshooting-called-during-build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(asyncCustomerInfoProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final future = ref.watch(asyncCustomerInfoProvider);

    return Scaffold(
      appBar: AppBarDefault(
        title: t.users.contract_details,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveValues.horizontalMargin(context),
        ),
        child: future.when(
          loading: () => const LoadingSpinner(),
          error: (err, stack) => Text('Error: $err'),
          data: (data) => PurchaseContractDetailsScreen(customerInfo: data),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
