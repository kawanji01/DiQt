import 'package:booqs_mobile/components/markdown/dict_link_screen.dart';
import 'package:booqs_mobile/models/search_history.dart';
import 'package:flutter/material.dart';

class SearchHistoryListItem extends StatelessWidget {
  const SearchHistoryListItem({
    super.key,
    required this.searchHistory,
  });

  final SearchHistory searchHistory;

  Widget _buildDeviceTypeBadge(BuildContext context) {
    String label;
    Color backgroundColor;

    switch (searchHistory.deviceType) {
      case 'web':
        label = 'ウェブ';
        backgroundColor = Colors.blue;
        break;
      case 'app':
        label = 'アプリ';
        backgroundColor = Colors.green;
        break;
      case 'extension':
        label = '拡張機能';
        backgroundColor = Colors.orange;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.toLocal().toString().split(' ')[0]} ${dateTime.toLocal().toString().split(' ')[1].substring(0, 5)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          searchHistory.keywords ?? '',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              searchHistory.dictionary?.title ?? '不明な辞書',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              _formatDateTime(searchHistory.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: _buildDeviceTypeBadge(context),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            builder: (context) => MarkdownDictLinkScreen(
              dictionaryId: searchHistory.dictionaryId,
              keyword: searchHistory.keywords ?? '',
            ),
          );
        },
      ),
    );
  }
}
