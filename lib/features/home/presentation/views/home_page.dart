import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_gridview_shimmer.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/widgets/custom_search_app_bar.dart';
import 'package:saturn/features/home/presentation/widgets/custom_home_arts_grid_view.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_listview_separated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> posts = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final arts = context.watch<HomeCubit>().posts;

              if (state is GetAllCategorisFailure) {
                return Center(child: Text(state.errMessage));
              } else if (state is GetAllCategorisLoading || arts == null) {
                return Center(child: CustomGridViewShimmer(length: 10));
              } else {
                return Column(
                  children: [
                    verticalSpace(10),
                    CustomSearchAppBar(
                      onChanged: (input) {
                        input = input.trim();
                        setState(() {
                          isSearching = input.isNotEmpty;
                          posts = AppFunctions().searchPosts(arts, input) ?? [];
                        });
                      },
                    ),
                    verticalSpace(30),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: CustomCategoryListviewSeparated(),
                          ),

                          if (isSearching)
                            SliverToBoxAdapter(
                              child:
                                  posts.isEmpty
                                      ? Text(
                                        'no posts found',
                                        style: AppTextstyles.font24BlackeBold
                                            .copyWith(color: AppColors.red),
                                        textAlign: TextAlign.center,
                                      )
                                      : CustomHomeArtsGridView(
                                        postModels: posts,
                                      ),
                            )
                          else
                            SliverToBoxAdapter(
                              child: CustomHomeArtsGridView(postModels: arts),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
