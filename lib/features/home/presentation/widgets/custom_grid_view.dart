

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        shrinkWrap: true,
        
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, i) {
          return Column(
            children: [
              Image.asset(Assets.assetsImagesPainting , height: 50.h,),
              Text('painting' , style: AppTextstyles.font16WhiteMeduim,),
            ],
          );
        },
      ),
    );
  }
}
