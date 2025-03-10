import 'package:flutter/material.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/widgets/custom_text_filed.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            focusdBorderColor: AppColors.white,
            backgroundColor: AppColors.lightPurple,
            hintText: 'search',
            hintTextStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
        horizontalSpace(20),
        CircleAvatar(backgroundImage: AssetImage(Assets.assetsImagesAppLogo)),
      ],
    );
  }
}
