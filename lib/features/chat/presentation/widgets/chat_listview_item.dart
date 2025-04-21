import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';

class ChatListviewItem extends StatelessWidget {
  const ChatListviewItem({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    CircleAvatar(
      radius: 32.r,
      backgroundImage: 
      user.picName == null ?
      AssetImage(Assets.assetsImagesEmptyAvater):
       NetworkImage(ApiConstants.upload + user.picName!)
      ,
    ),
            
        

        horizontalSpace(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.username!,
              style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 15.sp),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,

                'hi Mo im ali how are you ?',
                style: AppTextstyles.font14LigtGreyRegular,
              ),
            ),
          ],
        ),
        Spacer(),
        Text('08:65 pm', style: AppTextstyles.font14LigtGreyRegular),
      ],
    );
  }
}
