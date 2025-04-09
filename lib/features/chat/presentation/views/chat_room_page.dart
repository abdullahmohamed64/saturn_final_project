import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/presentation/widgets/chat_room_listview_messages.dart';
import 'package:saturn/features/chat/presentation/widgets/send_message_text_field.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, required this.receiverData});
  final UserModel receiverData;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isLoading = true;
  String? chatId;

  late int currentUserId; // Replace with actual user ID later

  @override
  void initState() {
    _getChatIdAndUserId();
    super.initState();
  }

  Future<void> _getChatIdAndUserId() async {
    isLoading = true;
    currentUserId = await SharedPrefHelper.getInt(SharedPrefKeys.userIdKey);
    chatId = await ChatService().createOrGetChat(
      userId1: currentUserId.toString(),
      userId2: widget.receiverData.id.toString(),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child:
              isLoading || chatId == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      verticalSpace(20),
                      SizedBox(
                        height: 50.h,
                        child: Text(
                          widget.receiverData.username!,
                          textAlign: TextAlign.center,
                          style: AppTextstyles.font16WhiteSemiBold.copyWith(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ChatRoomListviewMessages(
                          chatId: chatId!,
                          senderId: currentUserId.toString(),
                        ),
                      ),
                      verticalSpace(20),
                      SendMessageTextField(
                        chatId: chatId!,
                        senderId: currentUserId.toString(),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
