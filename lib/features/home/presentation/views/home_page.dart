import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:saturn/features/home/presentation/widgets/custom_home_arts_grid_view.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_listview_separated.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetAllCategorisFailure) {
                return Center(child: Text(state.errMessage));
              } else if (state is GetAllCategorisSuccess) {
                return Column(
                  children: [
                    CustomAppBar(),
                    verticalSpace(30),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          // !!!!!!!!!!!!!!! categories
                          SliverToBoxAdapter(
                            child: CustomCategoryListviewSeparated(),
                          ),
                          //!!!!!!!!!!arts
                          SliverToBoxAdapter(
                            child: CustomHomeArtsGridView(
                              artModels: state.arts,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
