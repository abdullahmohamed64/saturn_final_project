
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_textstyles.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text, required this.clickedTex});
  final String text;
  final String clickedTex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w),
      child:
          clickedTex == text
              ? Text(
                text,
                style: AppTextstyles.font16WhiteMeduim.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                ),
              )
              : Text(text, style: AppTextstyles.font16WhiteMeduim),
    );
  }
}