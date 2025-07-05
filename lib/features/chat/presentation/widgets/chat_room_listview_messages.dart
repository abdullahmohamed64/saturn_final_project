import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';
import 'package:saturn/features/chat/presentation/widgets/buble_message.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class ChatRoomListviewMessages extends StatelessWidget {
  const ChatRoomListviewMessages({
    super.key,
    required this.chatId,
    required this.senderId,
    required this.userName,
  });
  final String chatId;
  final String senderId;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(30),
        SizedBox(
          height: 50.h,
          child: Text(
            userName,
            textAlign: TextAlign.center,
            style: AppTextstyles.font16WhiteSemiBold.copyWith(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 20.sp,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: ChatService().getChatMessages(chatId: chatId),
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
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return Center(
                  child: Text(
                    "No messages yet.",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }

              Map<dynamic, dynamic> messages =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages found.",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }
              context.read<HomeCubit>().getListOfUsersById(senderId.toString());
              List<MapEntry<dynamic, dynamic>> sortedMessages =
                  messages.entries.toList();
              sortedMessages.sort(
                (a, b) => b.value[AppConstants.timeStamp].compareTo(
                  a.value[AppConstants.timeStamp],
                ),
              );
              return ListView.builder(
                reverse: true,

                itemCount: sortedMessages.length,
                itemBuilder: (context, i) {
                  var message = sortedMessages[i].value;

                  MessageModel messageModel = MessageModel.fromMap(
                    message,
                    "",
                    "",
                  );
                  bool isReceiver = messageModel.senderId.toString() != senderId;
                  return BubbleMessage(
                    isReceiver: isReceiver,
                    messageModel: messageModel,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
