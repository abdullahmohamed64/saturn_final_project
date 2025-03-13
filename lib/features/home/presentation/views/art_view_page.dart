import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/presentation/widgets/art_view_item.dart';

class ArtViewPage extends StatelessWidget {
  const ArtViewPage({super.key, required this.artModel});
  final ArtModel artModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is ReactedLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                artModel.description,
                style: AppTextstyles.font16WhiteMeduim,
              ),
              Text(artModel.createdAt, style: AppTextstyles.font16WhiteMeduim),
              ArtViewItem(artModel: artModel),
              Text(
                state is ReactedSuccefully ? 
                state.favouriteRsponseModel.likesCount.toString()
                :
                 artModel.likesCount.toString(),
                style: AppTextstyles.font16WhiteMeduim,
              ),
              IconButton(
                onPressed: () {
                  context.read<FavoriteCubit>().emitReact(artId: artModel.id);

                  // context.read<FavoriteCubit>().emitGetPostReact(artId: artModel.id);
                },
                icon: Icon(
                  Icons.favorite,
                  color:
                      state is ReactedSuccefully
                          ? state.favouriteRsponseModel.liked!
                              ? Colors.red
                              : Colors.grey
                          : Colors.grey,
                ),
              ),

              Row(),
            ],
          );
        },
      ),
    );
  }
}
