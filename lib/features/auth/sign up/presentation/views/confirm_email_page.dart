import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/core/widgets/dashed_line.dart';


class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          margin: EdgeInsets.only(top: 30.h),
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                horizontalSpace(double.infinity),
                verticalSpace(20),
                DashedLine(),
                verticalSpace(30),
                Image.asset(
                  Assets.assetsImagesOTPImage,
                  width: 300,
                  height: 300,
                ),
                verticalSpace(20),
                Text(
                  'Confirm your email',
                  style: AppTextstyles.font24BlueBold.copyWith(
                    color: Colors.black,
                  ),
                ),
                verticalSpace(20),
                Text(
                  'we have sent a confirmation link to your email',
                  style: AppTextstyles.font14GreyRegular,
                ),
                verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter verification code',
                      style: AppTextstyles.font18BlackRegular,
                    ),
                  ],
                ),
                verticalSpace(15),
                CustomTextFormField(
                  width: 350,
                  hintText: 'enter verification code',
                ),

                verticalSpace(25),
                AppButton(
                  width: 350,
                  title: Text(
                    'Verify and Create account',
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                  onPressed: () {},
                ),
                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
