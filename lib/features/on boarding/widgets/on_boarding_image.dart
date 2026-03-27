
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';

class OnBoardingImage extends StatelessWidget {
  const OnBoardingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 46.5.w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          Assets.assetsImagesOnBoardingImage,
          width: 300.w,
          height: 300.h,
        ),
      ),
    );
  }
}


