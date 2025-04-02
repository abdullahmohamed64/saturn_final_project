import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class UserListviewPhotosItem extends StatelessWidget {
  const UserListviewPhotosItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CircleAvatar(
          radius: 32.h,
          backgroundImage: AssetImage(Assets.assetsImagesMan2),),
        verticalSpace(8),
        Text('ali' , style: AppTextstyles.font14GreyRegular.copyWith(color: AppColors.theMostlightGrey),)
      ],
    );
  }
}