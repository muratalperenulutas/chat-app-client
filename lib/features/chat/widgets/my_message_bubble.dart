import 'package:chat_app/features/chat/helper/status_icon_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors/message_card.dart';
import '../../../data/message/message.dart';

class MyMessageBubble extends StatelessWidget {
  const MyMessageBubble({
    super.key,
    required this.message,
    required this.collectivityId,
  });

  final Message message;
  final String collectivityId;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MessageCardColorHelper.getColorFromPredefined(
          message.userId, collectivityId),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Stack(children: [
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text(
                    maxLines: 6,
                    message.message,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: 50,
                )
              ],
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                    child: Row(
                  children: [
                    Text(
                      DateFormat("HH:mm").format(message.sendTime),
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(StatusIconPicker(message.status), size: 14)
                  ],
                )))
          ])),
    );
  }
}
