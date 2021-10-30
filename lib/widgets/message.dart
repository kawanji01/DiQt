import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Message route arguments.
class MessageArguments {
  MessageArguments(this.message, {required this.openedApplication})
      : assert(message != null);

  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;
}

/// Displays information about a [RemoteMessage].
class MessageView extends StatelessWidget {
  /// A single data row.
  Widget row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(children: [
        Text('$title: '),
        Text(value),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MessageArguments;
    final RemoteMessage message = args.message;
    final notification = message.notification;

    return Scaffold(
      appBar: AppBar(
        title: Text(message.messageId as String),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          row('Triggered application open', args.openedApplication.toString()),
          row('Message ID', message.messageId as String),
          row('Sender ID', message.senderId as String),
          row('Category', message.category as String),
          row('Collapse Key', message.collapseKey as String),
          row('Content Available', message.contentAvailable.toString()),
          row('Data', message.data.toString()),
          row('From', message.from as String),
          row('Message ID', message.messageId as String),
          row('Sent Time', message.sentTime as String),
          row('Thread ID', message.threadId as String),
          row('Time to Live (TTL)', message.ttl as String),
          if (notification != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(children: [
                const Text(
                  'Remote Notification',
                  style: TextStyle(fontSize: 18),
                ),
                row(
                  'Title',
                  notification.title as String,
                ),
                row(
                  'Body',
                  notification.body as String,
                ),
                if (notification.android != null) ...[
                  const Text(
                    'Android Properties',
                    style: TextStyle(fontSize: 18),
                  ),
                  row(
                    'Channel ID',
                    notification.android!.channelId as String,
                  ),
                  row(
                    'Click Action',
                    notification.android!.clickAction as String,
                  ),
                  row(
                    'Color',
                    notification.android!.color as String,
                  ),
                  row(
                    'Count',
                    notification.android!.count as String,
                  ),
                  row(
                    'Image URL',
                    notification.android!.imageUrl as String,
                  ),
                  row(
                    'Link',
                    notification.android!.link as String,
                  ),
                  row(
                    'Priority',
                    notification.android!.priority as String,
                  ),
                  row(
                    'Small Icon',
                    notification.android!.smallIcon as String,
                  ),
                  row(
                    'Sound',
                    notification.android!.sound as String,
                  ),
                  row(
                    'Ticker',
                    notification.android!.ticker as String,
                  ),
                  row(
                    'Visibility',
                    notification.android!.visibility as String,
                  ),
                ],
                if (notification.apple != null) ...[
                  const Text(
                    'Apple Properties',
                    style: TextStyle(fontSize: 18),
                  ),
                  row(
                    'Subtitle',
                    notification.apple!.subtitle as String,
                  ),
                  row(
                    'Badge',
                    notification.apple!.badge as String,
                  ),
                  row(
                    'Sound',
                    notification.apple!.sound!.name as String,
                  ),
                ]
              ]),
            )
          ]
        ]),
      )),
    );
  }
}
