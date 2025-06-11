import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/chat_title_model.dart';

class ChatListviewItem extends StatelessWidget {
  const ChatListviewItem({super.key, required this.chatTileModel});
  final ChatTileModel chatTileModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32.r,
          backgroundImage:
              chatTileModel.userImage == null
                  ? AssetImage(Assets.assetsImagesUserAvatar)
                  : NetworkImage(
                    ApiConstants.upload + chatTileModel.userImage!,
                  ),
        ),

        horizontalSpace(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatTileModel.username,
              style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,

                chatTileModel.lastMessage,
                style: AppTextstyles.font14LigtGreyRegular,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(chatTileModel.lastMessageTime, style: AppTextstyles.font14LigtGreyRegular),
      ],
    );
  }
}
