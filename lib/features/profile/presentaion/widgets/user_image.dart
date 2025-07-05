import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/profile/logic/edit%20user%20cubit/edit_user_profile_cubit.dart';

import '../../../../constants/assets.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.user, this.editCubit});
  final UserModel user;
  final EditUserProfileCubit? editCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),

        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 50.r,
          child: CircleAvatar(
            backgroundImage:
                editCubit?.image != null
                    ? FileImage(editCubit!.image!)
                    : user.picName == null
                    ? AssetImage(Assets.assetsImagesUserAvatar)
                    : NetworkImage(
                      ApiConstants.uploadUrl.toString() + user.picName!,
                    ),
            radius: 45.r,
          ),
        ),
        verticalSpace(10),
        Text(
          user.username?.replaceFirst(
                user.username![0],
                user.username![0].toUpperCase(),
              ) ??
              '',
          style: AppTextstyles.userNameFont,
        ),
        verticalSpace(20),
      ],
    );
  }
}
