import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';

import '../../../../constants/assets.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,

      child: CircleAvatar(
        backgroundColor: AppColors.white,
        radius: 50.r,
        child: CircleAvatar(
          backgroundImage: AssetImage(Assets.assetsImagesDesign),
          radius: 45.r,
        ),
      ),
    );
  }
}