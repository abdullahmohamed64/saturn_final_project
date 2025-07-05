import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/chat_title_model.dart';
import 'package:saturn/features/chat/presentation/widgets/chat_listview_item.dart';

class ChatsListContainer extends StatelessWidget {
  const ChatsListContainer({super.key, required this.chatTileModels});
  final List<ChatTileModel> chatTileModels;

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
        child:
            chatTileModels.isEmpty
                ? Center(
                  child: Text(
                    'No Chats yet',
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                )
                : ListView.separated(
                  separatorBuilder: (context, index) => verticalSpace(30),
                  itemCount: chatTileModels.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        UserModel user = UserModel(
                          id: int.parse(chatTileModels[i].receiverId),
                          username: chatTileModels[i].username,
                        );
                        context.pushNamed(Routes.chatRoomPage, args: user);
                      },
                      child: ChatListviewItem(chatTileModel: chatTileModels[i]),
                    );
                  },
                ),
      ),
    );
  }
}
