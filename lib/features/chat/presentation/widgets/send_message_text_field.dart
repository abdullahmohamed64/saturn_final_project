import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_text_filed.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
    
      child: CustomTextField(
        textFieldStyle: AppTextstyles.font16WhiteMeduim,
        hintTextStyle: AppTextstyles.font12WhiteRegular,
        enabledBorderColor: AppColors.senderMessageColor,
        focusdBorderColor: AppColors.senderMessageColor,
        backgroundColor: AppColors.senderMessageColor,
        hintText: 'Message',
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.send , color: AppColors.white,)),
      ),
    );
  }
}
