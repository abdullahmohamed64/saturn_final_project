import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/dashed_line.dart';
import 'package:saturn/features/auth/sign%20in/presentation/widgets/custom_sign_in_bloc_listener.dart';

import '../widgets/custom_sign_in_form.dart';
import '../widgets/dont_have_an_account.dart';
import '../widgets/google_and_facebook_icons.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
                verticalSpace(50),
                DashedLine(),
                verticalSpace(20),
                Text(
                  'Welcome Back!',
                  style: AppTextstyles.font24BlueBold.copyWith(
                    color: Colors.black,
                  ),
                ),
                verticalSpace(10),
                Text(
                  'Let\'s login for explore continues ',
                  style: AppTextstyles.font14GreyRegular,
                ),
                verticalSpace(20),
                Image.asset(
                  Assets.assetsImagesAppLogo,
                  width: 100,
                  height: 100,
                ),
                verticalSpace(40),
                CustomSignInForm(), //!!!!!!!!!!!!!!!!!!!!!!!!form
                verticalSpace(10),
                Text('you can connect with'),
                verticalSpace(10),

                GoogleAndFacebookIcons(),
                verticalSpace(20),
                DontHaveAnAccount(),
                verticalSpace(30),

                CustomSignInBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
