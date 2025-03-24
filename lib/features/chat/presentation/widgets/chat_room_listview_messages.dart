
import 'package:flutter/material.dart';
import 'package:saturn/features/chat/presentation/widgets/buble_message.dart';

class ChatRoomListviewMessages extends StatelessWidget {
  const ChatRoomListviewMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, i) {
          return Column(children: [
            BubbleMessage(isSender: true,),
            BubbleMessage(isSender: false,)
            
            ]);
        },
      ),
    );
  }
}
