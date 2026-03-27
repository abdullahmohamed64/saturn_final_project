import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:saturn/features/favourite/data/repo/favorite_repo.dart';
import 'package:saturn/features/favourite/logic/cubit/art_state.dart';

class ArtCubit extends Cubit<ArtState> {
  ArtCubit(this._favouriteRepo) : super(FavouriteInitial());

  final FavouriteRepo _favouriteRepo;
  final TextEditingController commentController = TextEditingController();

  // Handle reactions to art
  Future<void> emitMakeReact({required int artId}) async {
    emit(GetPostReactsAndCommentsLoading());

    final result = await _favouriteRepo.makeReact(artId: artId);

    result.fold(
      (errorMessage) => emit(MakeReactFailure(errMessage: errorMessage)),
      (_) => emitGetPostReactAndComments(
        artId: artId,
      ), // Refresh data after reaction
    );
  }

  // Create a new comment
  Future<void> emitCreateComment({required int artId}) async {
    // Don't process empty comments
    if (commentController.text.trim().isEmpty) return;

    emit(GetPostReactsAndCommentsLoading());

    final comment = commentController.text;
    final result = await _favouriteRepo.createComment(
      artId: artId,
      comment: comment,
    );

    result.fold(
      (errorMessage) => emit(CreateCommentFailure(errMessage: errorMessage)),
      (_) {
        commentController.clear(); // Clear input field after successful comment
        emitGetPostReactAndComments(artId: artId); // Refresh comments list
      },
    );
  }

  // Get reactions and comments for a post
  Future<void> emitGetPostReactAndComments({required int artId}) async {
    emit(GetPostReactsAndCommentsLoading());

    final result = await _favouriteRepo.getPostReactAndComments(artId: artId);

    result.fold(
      (errorMessage) =>
          emit(GetPostReactsAndCommentsFailure(errMessage: errorMessage)),
      (favoriteModel) => emit(
        GetPostReactsAndCommentsSucceFully(
          favouriteRsponseModel: favoriteModel,
        ),
      ),
    );
  }



  @override
  Future<void> close() {
    commentController.dispose(); // Clean up resources
    return super.close();
  }
}
