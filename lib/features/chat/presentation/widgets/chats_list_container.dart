import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/presentation/widgets/chat_listview_item.dart';

class ChatsListContainer extends StatelessWidget {
  const ChatsListContainer({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 32.h, right: 12.w, left: 12.w),

        decoration: BoxDecoration(
          color: AppColors.usersProfileChatContainerColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => verticalSpace(30),
          itemCount: users.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(Routes.chatRoomPage, args: users[i]);
              },
              child: ChatListviewItem(user: users[i]),
            );
          },
        ),
      ),
    );
  }
}
