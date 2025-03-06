import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/dashed_line.dart';
import 'package:saturn/features/auth/sign%20up/presentation/widgets/sign_up_blocListener.dart';

import '../widgets/custom_sign_up_form.dart';
import '../widgets/already_have_account.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          margin: EdgeInsets.only(top: 32.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(20),
                DashedLine(),
                verticalSpace(20),
                Text(
                  'Create Your Account',
                  style: AppTextstyles.font24BlueBold.copyWith(
                    color: Colors.black,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'create account for explroing arts',
                  style: AppTextstyles.font14GreyRegular,
                ),
                verticalSpace(20),
                Image.asset(
                  Assets.assetsImagesAppLogo,
                  width: 100,
                  height: 100,
                ),
                verticalSpace(40),
                CustomSignUpForm(), //!!!!!!!!!!!!!!!!!!!!!!!!form

                verticalSpace(20),
                AlreadyHaveAnAccount(),
                verticalSpace(30),
                SignUpBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
