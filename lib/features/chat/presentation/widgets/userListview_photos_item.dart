import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';

class UserListviewPhotosItem extends StatelessWidget {
  const UserListviewPhotosItem({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32.h,
          backgroundImage:
              userModel.picName != null
                  ? NetworkImage(
                    ApiConstants.uploadUrl.toString() + userModel.picName!,
                  )
                  : AssetImage(Assets.assetsImagesUserAvatar),
        ),
        verticalSpace(8),
        Text(
          userModel.username ?? 'no name',
          style: AppTextstyles.font14GreyRegular.copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
