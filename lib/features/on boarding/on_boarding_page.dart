import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/features/on%20boarding/widgets/on_boarding_image.dart';
import 'package:saturn/features/on%20boarding/widgets/white_container.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomWhiteContainer(),
                  verticalSpace(150),
                  Text(
                    textAlign: TextAlign.center,
                    'Get Started with Us! \n 🎨✨',
                    style: AppTextstyles.font24BlueBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  verticalSpace(20),
                  Text(
                    textAlign: TextAlign.center,
                    'Welcome to our creative world of \nHandmade Crafts, Custom Logos, and \nUnique Paintings! Whether you\'re \nlooking for a personalized gift, a brand \nidentity, or a stunning artwork, you \'re in \nthe right place.',
                    style: AppTextstyles.font14LigtGreyRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  verticalSpace(20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64.w),
                    child: AppButton(
                      onPressed: () {
                        context.pushNamedAndRemoveUntile(
                          Routes.signInPage,
                          predicate: (route) => false,
                        );
                      },
                      backgroungColor: AppColors.mainPurple,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'GET STARTED',
                            style: AppTextstyles.font16WhiteMeduim,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(30),
                ],
              ),
              OnBoardingImage(),
            ],
          ),
        ),
      ),
    );
  }
}





/// my design!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
                    backgroundColor: AppColors.mainColor,
        // backgroundColor: Colors.black,
        body: Stack(
        
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 250.h,
                  decoration: BoxDecoration(
         
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                verticalSpace(150),
                Text(
                  textAlign: TextAlign.center,
                  'Get Started with Us! \n 🎨✨',
                  style: AppTextstyles.font24BlueBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                verticalSpace(20),
                Text(
                  textAlign: TextAlign.center,
                  'Welcome to our creative world of \nHandmade Crafts, Custom Logos, and \nUnique Paintings! Whether you\'re \nlooking for a personalized gift, a brand \nidentity, or a stunning artwork, you \'re in \nthe right place.',
                  style: AppTextstyles.font14LigtGreyRegular.copyWith(
                    color: Colors.white,
                  ),
                ),
                verticalSpace(20),
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: AppButton(
                    backgroungColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GET STARTED',
                          style: AppTextstyles.font16WhiteMeduim.copyWith(
                            color: AppColors.mainColor,
                          ),
                        ),
                        Icon(Icons.arrow_forward, size: 32, color:AppColors.mainColor),
                      ],
                    ),
                  ),
                ),
                verticalSpace(30),
              ],
            ),
            Positioned(
              top: 30,
              left: 46.5.w,
              child: Container(
                decoration: BoxDecoration(
             
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  Assets.assetsImagesArts,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/