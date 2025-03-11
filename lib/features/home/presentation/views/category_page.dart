import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(50),
              Text(
                'Painting',
                style: AppTextstyles.font24LightPurpleRegular,
                textAlign: TextAlign.center,
              ),
              verticalSpace(70),
              CustomCategoryItemsGridView(),
            ],
          ),
        ),
      ),
    );
  }
}


