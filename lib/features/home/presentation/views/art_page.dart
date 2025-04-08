import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';

import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_listview_shimmer.dart';
import 'package:saturn/core/widgets/custom_text_filed.dart';
import 'package:saturn/features/favourite/logic/cubit/art_state.dart';
import 'package:saturn/features/favourite/logic/cubit/favorite_cubit.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/presentation/functions/handle_error.dart';
import 'package:saturn/features/home/presentation/widgets/art_image_secion.dart';
import 'package:saturn/features/home/presentation/widgets/comment_widget.dart';

class ArtPage extends StatefulWidget {
  const ArtPage({super.key, required this.artModel});
  final ArtModel artModel;

  @override
  State<ArtPage> createState() => _ArtPageState();
}

class _ArtPageState extends State<ArtPage> {
  bool showCommentInput = false;

  @override
  void initState() {
    super.initState();
    // Load comments when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArtCubit>().emitGetPostReactAndComments(
        artId: widget.artModel.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.read<ArtCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightPurple,
        body: BlocConsumer<ArtCubit, ArtState>(
          listener: (context, state) {
            handleError(context, state);
          },
          builder: (context, state) {
            final bool isLoading = state is GetPostReactsAndCommentsLoading;
            // final bool hasCommentsAndPosts =
            //     state is GetPostReactsAndCommentsSucceFully;

            return Column(
              children: [
                _buildArtImageSection(state),
                verticalSpace(15),
                _buildCommentInputSection(favoriteCubit),
                verticalSpace(15),
                Expanded(
                  child:
                      isLoading
                          ? const Center(child: CustomListViewShimmer())
                          : _buildCommentsList(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildArtImageSection(ArtState state) {
    final bool isSuccess = state is GetPostReactsAndCommentsSucceFully;
    final int likeCount =
        isSuccess
            ? state.favouriteRsponseModel.likesCount!
            : widget.artModel.likesCount!;
    final bool isLiked = isSuccess && state.favouriteRsponseModel.liked == true;

    return ArtImageSecion(
      likesCount: likeCount,
      artId: widget.artModel.id!,
      isLiked: isLiked,
      onCommentPress: () {
        setState(() {
          showCommentInput = !showCommentInput;
        });
      },
    );
  }

  Widget _buildCommentInputSection(ArtCubit favoriteCubit) {
    if (!showCommentInput) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SizedBox(
        height: 80.h,

        child: CustomTextField(
          onChanged: (_) => setState(() {}),
          prefixIcon:
              favoriteCubit.commentController.text.isNotEmpty
                  ? IconButton(
                    onPressed: () {
                      favoriteCubit.emitCreateComment(
                        artId: widget.artModel.id ?? 0,
                      );
                    },
                    icon: Icon(Icons.send, color: AppColors.deepPurple),
                  )
                  : null,
          hintText: 'Add comment',
          controller: favoriteCubit.commentController,
        ),
      ),
    );
  }

  Widget _buildCommentsList(ArtState state) {
    if (state is! GetPostReactsAndCommentsSucceFully) {
      return const SizedBox.shrink();
    }

    final comments = state.favouriteRsponseModel.comments ?? [];

    if (comments.isEmpty) {
      return Center(
        child: Text(
          'No comments yet. Be the first to comment!',
          style: AppTextstyles.font16WhiteSemiBold,
        ),
      );
    }

    return ListView.separated(
      itemCount: comments.length,
      // separatorBuilder: (context, _) => const Divider(),
      separatorBuilder: (context, index) => verticalSpace(2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommentWidget(
            comment: comments[index].comment ?? '',
            userName: comments[index].username ?? '',
            createdAt: comments[index].createdAt ?? '',
            userAvatar: null,
          ),
        );
      },
    );
  }
}
