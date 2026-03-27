import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';

import '../../../../constants/assets.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,

      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 50.r,
            child: CircleAvatar(
              backgroundImage:
              user.picName == null?
               AssetImage(Assets.assetsImagesDesign)
               :
               NetworkImage(ApiConstants.upload  + user.picName!)
               ,
              radius: 45.r,
            ),
          ),
          verticalSpace(10),
          Text(user.username! , style: AppTextstyles.font16WhiteMeduim,)
        ],
      ),
    );
  }
}