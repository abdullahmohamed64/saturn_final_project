import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/presentation/widgets/chat_room_listview_messages.dart';
import 'package:saturn/features/chat/presentation/widgets/send_message_text_field.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              verticalSpace(20),
              SizedBox(
                height: 50.h,
                child: Text(
                  'Mohamed',

                  textAlign: TextAlign.center,
                  style: AppTextstyles.font16WhiteSemiBold.copyWith(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              ChatRoomListviewMessages(),
             verticalSpace(20),
              SendMessageTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
