import 'package:booqs_mobile/components/layouts/app_bar/default.dart';
import 'package:booqs_mobile/components/layouts/bottom_navbar/bottom_navbar.dart';
import 'package:booqs_mobile/components/search_history/item_list_view.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:booqs_mobile/components/shared/premium_recommendation.dart';
import 'package:booqs_mobile/data/provider/current_user.dart';
import 'package:booqs_mobile/data/provider/search_history.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/routes.dart';
import 'package:booqs_mobile/utils/responsive_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHistoryIndexPage extends ConsumerWidget {
  const SearchHistoryIndexPage({super.key});

  static Future push(BuildContext context) async {
    return Navigator.of(context).pushNamed(searchHistoryIndexPage);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    if (user == null) return const LoadingSpinner();

    final String order = ref.watch(searchHistoryOrderProvider);
    final String deviceType = ref.watch(searchHistoryDeviceTypeProvider);

    Widget searchHistoryContent() {
      if (ref.watch(premiumEnabledProvider) == false) {
        return Container(
          margin: const EdgeInsets.only(top: 48),
          child: SharedPremiumRecommendation(
              description: t.shared.premium_recommendation),
        );
      }
      return SearchHistoryItemListView(
        key: UniqueKey(),
        order: order,
        deviceType: deviceType,
      );
    }

    Widget filterForm() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'デバイス',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: deviceType,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: '', child: Text('すべてのデバイス')),
                      DropdownMenuItem(value: 'web', child: Text('Web')),
                      DropdownMenuItem(value: 'app', child: Text('アプリ')),
                      DropdownMenuItem(value: 'extension', child: Text('拡張機能')),
                    ],
                    onChanged: (value) {
                      ref.read(searchHistoryDeviceTypeProvider.notifier).state = value ?? '';
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '並び順',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: order,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'created_at-desc', child: Text('新しい順')),
                      DropdownMenuItem(value: 'created_at-asc', child: Text('古い順')),
                    ],
                    onChanged: (value) {
                      ref.read(searchHistoryOrderProvider.notifier).state = value ?? 'created_at-desc';
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: '検索履歴',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: ResponsiveValues.horizontalMargin(context),
          ),
          child: Column(
            children: [
              filterForm(),
              const SizedBox(height: 16),
              searchHistoryContent(),
              const SizedBox(height: 240),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
