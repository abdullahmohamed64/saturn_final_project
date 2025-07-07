import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/data/models/category_name_and_image_model.dart';

class CustomCategoryListviewSparatedItem extends StatelessWidget {
  const CustomCategoryListviewSparatedItem({
    super.key,
    required this.categoryNameAndImageModel,
  });
  final CategoryNameAndImageModel categoryNameAndImageModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.sp),
          height: 100.h,
          width: 80.w,
      
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage(categoryNameAndImageModel.categoryImage,)),
            color: categoryNameAndImageModel.categoryColor,
                // color: AppColors.grey,
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Image.asset(
            categoryNameAndImageModel.categoryImage,
            height: 80.h,
            // width: 120.w,
          ),
        ),
        verticalSpace(10),
        Text(
          categoryNameAndImageModel.categoryName,
          style: AppTextstyles.font16WhiteMeduim.copyWith(
            fontSize: 14.sp,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
