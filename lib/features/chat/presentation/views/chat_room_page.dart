import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/presentation/widgets/chat_room_listview_messages.dart';
import 'package:saturn/features/chat/presentation/widgets/send_message_text_field.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isLoading = true;
  String? chatId;

  late int currentUserId;

  @override
  void initState() {
    _getChatIdAndUserId();
    super.initState();
  }

  Future<void> _getChatIdAndUserId() async {
    isLoading = true;
    currentUserId = AppFunctions.getUserId()??0;
    chatId = await ChatService().createOrGetChat(
      userId1: currentUserId.toString(),
      userId2: widget.user.id.toString(),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColorPurple,
        toolbarHeight: 138.h,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.arrowBackBakgroundColor,
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.arrowBackColor,
            ),
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      backgroundColor: AppColors.appBarColorPurple,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.usersProfileChatContainerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(64.r),
              topRight: Radius.circular(64.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child:
                isLoading || chatId == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                      children: [
                        Expanded(
                          child: ChatRoomListviewMessages(
                            userName: widget.user.username ?? "un known",
                            chatId: chatId!,
                            senderId: currentUserId.toString(),
                          ),
                        ),
                        verticalSpace(20),
                        SendMessageTextField(
                          chatId: chatId!,
                          senderId: currentUserId,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
