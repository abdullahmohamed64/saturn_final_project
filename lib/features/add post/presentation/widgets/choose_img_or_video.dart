
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';

class ChooseImageOrVideoWidget extends StatelessWidget {
  const ChooseImageOrVideoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<AddPostCubit>().pickImageAndUpload();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.white
        ,
        borderRadius: BorderRadius.circular(16.sp),
      
        ),
             
        child: Center(
          
          child: Column(
            children: [
              Image.asset(
                Assets.assetsImagesSendToCloud,
                height: 50.h,
                width: 50.w,
              ),
              Text('choose image or video' , style: AppTextstyles.font12LigtGreyRegular,),
            ],
          ),
        ),
      ),
    );
  }
}
