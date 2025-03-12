import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:saturn/features/home/presentation/widgets/custom_arts_grid_view.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_listview_separated.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.mainPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomAppBar(),
              verticalSpace(30),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // SliverToBoxAdapter(child: verticalSpace(20)),
                    SliverToBoxAdapter(
                      child: CustomCategoryListviewSeparated(),
                    ),
                    SliverToBoxAdapter(child: CustomArtsGridView()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
