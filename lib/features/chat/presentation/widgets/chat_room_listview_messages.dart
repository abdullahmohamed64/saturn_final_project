import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/presentation/widgets/buble_message.dart';

class ChatRoomListviewMessages extends StatelessWidget {
  const ChatRoomListviewMessages({
    super.key,
    required this.chatId,
    required this.senderId,
  });
  final String chatId;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: ChatService().getMessagesOnChat(chatId: chatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 70.sp,
              ),
            );
          }

          if (snapshot.hasError) {
            return  Center(child: Text("Something went wrong" , style:AppTextstyles.font16WhitekSemiBold,));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return  Center(child: Text("No messages yet.",style:AppTextstyles.font16WhitekSemiBold));
          }

          Map<dynamic, dynamic> messages =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          if (messages.isEmpty) {
            return  Center(child: Text("No messages found." , style:AppTextstyles.font16WhitekSemiBold));
          }
          List<MapEntry<dynamic, dynamic>> sortedMessages =
              messages.entries.toList();
          sortedMessages.sort(
            (a, b) => a.value[AppConstants.timeStamp].compareTo(
              b.value[AppConstants.timeStamp],
            ),
          );
          return ListView.builder(
            reverse: true,

            itemCount: sortedMessages.length,
            itemBuilder: (context, i) {
              var message = sortedMessages[i].value;
              bool isSender = message[AppConstants.senderId] == senderId;
              return BubbleMessage(isSender: isSender, messageData: message);
            },
          );
        },
      ),
    );
  }
}
