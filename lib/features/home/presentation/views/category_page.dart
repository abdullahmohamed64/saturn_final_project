import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.categoryName});
  //  final List <ArtModel> arts ;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetAllCategorisFailure) {
                return Center(child: Text(state.errMessage));
              }
              else if (state is GetAllCategorisSuccess) {
                return Column(
                  children: [
                    verticalSpace(50),
                    Text(
                      categoryName,
                      style: AppTextstyles.font24LightPurpleRegular,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(70),
                    CustomCategoryItemsGridView(arts: state.arts),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
