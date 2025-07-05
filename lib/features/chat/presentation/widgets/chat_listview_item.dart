import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
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
          radius: 32.sp,

          child:
              chatTileModel.userImage.isNullOrEmpty()
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(32.sp),
                    child: Image.asset(
                      Assets.assetsImagesUserAvatar,
                      fit: BoxFit.cover,
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(32.sp),
                    child: CachedNetworkImage(
                      imageUrl:
                          chatTileModel.userImage.isNullOrEmpty()
                              ? 'https://tse4.mm.bing.net/th/id/OIP._qD62an0_iiWX0pzZRUOZwHaFj?r=0&rs=1&pid=ImgDetMain&o=7&rm=3'
                              : ApiConstants.uploadUrl.toString() +
                                  chatTileModel.userImage!,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
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
              width: MediaQuery.of(context).size.width / 3,
              child: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 2,

                chatTileModel.lastMessage,
                style: AppTextstyles.font14LigtGreyRegular,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          chatTileModel.lastMessageTime,
          style: AppTextstyles.font14LigtGreyRegular,
        ),
      ],
    );
  }
}
