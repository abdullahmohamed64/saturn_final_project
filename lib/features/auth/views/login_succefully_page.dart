import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/dashed_line.dart';

class LoginSuccefullyPage extends StatelessWidget {
  const LoginSuccefullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        margin: EdgeInsets.only(top: height / 6),
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
              verticalSpace(30),
              DashedLine(),
              verticalSpace(20),
              Image.asset(Assets.assetsImagesSuccess, width: 300, height: 300),
              verticalSpace(20),
              Text(
                'Yey! Login Successfull',
                style: AppTextstyles.font24BlueBold.copyWith(
                  color: Colors.black,
                ),
              ),
              verticalSpace(20),
              Text(
                'You will be moved to home screen right now.Enjoy the features!',
                style: AppTextstyles.font14GreyRegular,
              ),
              verticalSpace(15),

              verticalSpace(25),
              AppButton(
                width: 350,
                title: Text(
                  'Let\'s Explore',
                  style: AppTextstyles.font16WhiteMeduim,
                ),
                onPressed: () {
                  context.pushNamedAndRemoveUntile(
                    Routes.navigationPage,
                    predicate: (route) => false,
                  );
                },
              ),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}
