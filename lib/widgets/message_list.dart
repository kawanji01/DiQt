import 'package:booqs_mobile/widgets/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const Text('No messages received');
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final RemoteMessage message = _messages[index];

          return ListTile(
            title: Text(message.messageId as String),
            subtitle: Text(message.sentTime?.toString() ?? 'N/A'),
            onTap: () => Navigator.pushNamed(context, '/message',
                arguments: MessageArguments(message, openedApplication: false)),
          );
        });
  }
}
