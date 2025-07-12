import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';

class ChooseImageOrVideoWidget extends StatelessWidget {
  const ChooseImageOrVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (bcontext) {
            return SelectImageOrVideo(
              onCameraTap: () {
                context.read<AddPostCubit>().pickImageAndUpload();
                Navigator.pop(context);},
            
            );
          },
        );
        // context.read<AddPostCubit>().pickImageAndUpload();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
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
              Text(
                'choose image or video',
                style: AppTextstyles.font12LigtGreyRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageOrVideo extends StatelessWidget {
  const SelectImageOrVideo({
    super.key, this.onCameraTap, this.onVideoTap,
  });
 final void Function()? onCameraTap;
 final void Function()? onVideoTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainPurple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.all(16.sp),
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageAndVideoWidget(
            icon: Icons.image_outlined,
            title: 'Image',
            onTap:
                onCameraTap,
          ),
          verticalSpace(32),
          // ImageAndVideoWidget(
          //   title: 'Video',
          //   onTap:
          //       () =>onVideoTap,
          //   icon: Icons.video_collection_outlined,
          // ),
        ],
      ),
    );
  }
}

class ImageAndVideoWidget extends StatelessWidget {
  const ImageAndVideoWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text(title, style: AppTextstyles.font16WhiteSemiBold),
          horizontalSpace(250),
          Icon(icon, size: 30, color: AppColors.white),
        ],
      ),
    );
  }
}
