import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/presentation/widgets/user_listview_photos.dart';
import 'package:saturn/features/chat/presentation/widgets/users_profile_chat_container.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.deepPurple,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(30),
              Text(
                'Messages',
                style: AppTextstyles.font32BlueBold.copyWith(
                  color: AppColors.white,
                  fontSize: 28.sp,
                  fontFamily: GoogleFonts.pacifico().fontFamily,
                ),
              ),

              verticalSpace(10),

              Text(
                'R e c e n t',
                style: AppTextstyles.font13Greyregular.copyWith(
                  color: AppColors.lighterGrey,
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              verticalSpace(30),

              UserListviewPhotos(),
              UsersProfileChatContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
