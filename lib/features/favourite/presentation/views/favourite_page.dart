import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/back_icon_button.dart';
import 'package:saturn/core/widgets/custom_gridview_shimmer.dart';
import 'package:saturn/features/favourite/logic/cubit/get_user_favorite_arts_cubit.dart';

import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 132.h,
        backgroundColor: AppColors.white,
        leading: CustomBackIconButton(
          onPressed:
              () => context.pushNamedAndRemoveUntile(
            Routes.navigationPage,
            predicate: (route) => false,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.r),
             height: 720.h,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
          child: BlocBuilder<GetUserFavoriteArtsCubit, GetUserFavoriteArtsState>(
            builder: (context, state) {
              if (state is GetUserFavoriteArtsSucces) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCategoryItemsGridView(arts: state.arts),
                );
              } else if (state is GetUserFavoriteArtsFailure) {
                return Center(
                  child: Text(
                    state.errMessage,
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              } else {
                return Center(child: CustomGridViewShimmer());
              }
            },
          ),
        ),
      ),
    );
  }
}
