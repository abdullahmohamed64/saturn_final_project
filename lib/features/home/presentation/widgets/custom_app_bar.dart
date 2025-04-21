import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/widgets/custom_text_filed.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onChanged});
final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onChanged: onChanged,
            textFieldStyle: TextStyle(color:  AppColors.white),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(64.r),
              topRight: Radius.circular(64.r),
              bottomRight: Radius.circular(512.r),
              bottomLeft: Radius.circular(64.r),
            ),
            focusdBorderColor: AppColors.white,
            enabledBorderColor: AppColors.lightPurple,
            backgroundColor: AppColors.lightPurple,
            hintText: 'search',
            hintTextStyle: TextStyle(color: AppColors.theMostLighPurple),
            prefixIcon: Icon(Icons.search, color: AppColors.theMostLighPurple),
          ),
        ),
        horizontalSpace(20),
        CircleAvatar(backgroundImage: AssetImage(Assets.assetsImagesAppLogo)),
      ],
    );
  }
}
