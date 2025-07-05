import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_gridview_shimmer.dart';
import 'package:saturn/features/favourite/logic/cubit/get_user_favorite_arts_cubit.dart';

import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child:
            BlocBuilder<GetUserFavoriteArtsCubit, GetUserFavoriteArtsState>(
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
    );
  }
}
