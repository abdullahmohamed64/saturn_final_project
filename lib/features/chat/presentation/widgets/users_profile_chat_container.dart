import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/chat/presentation/widgets/users_profile_chat_item.dart';

class UsersProfileChatContainer extends StatelessWidget {
  const UsersProfileChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 54.h , right: 8.w , left: 8.w),
      
      decoration: BoxDecoration(
        color: AppColors.usersProfileChatContainerColor,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r),
       topRight: Radius.circular(32.r),
       ),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => verticalSpace(20),
        itemCount: 20,
        itemBuilder: (context,i){
         return UsersProfileChatItem();
      }),
      ),

    );
  }
}