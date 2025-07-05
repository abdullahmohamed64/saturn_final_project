import 'package:saturn/features/home/data/models/art_model.dart';

abstract class ArtState {}

class FavouriteInitial extends ArtState {}

class GetPostReactsAndCommentsSucceFully extends ArtState {
  final PostModel favouriteRsponseModel;

  GetPostReactsAndCommentsSucceFully({required this.favouriteRsponseModel});
}

class GetPostReactsAndCommentsFailure extends ArtState {
  final String errMessage;

  GetPostReactsAndCommentsFailure({required this.errMessage});
}

class GetPostReactsAndCommentsLoading extends ArtState {}

class MakeReactFailure extends ArtState {
  final String errMessage;

  MakeReactFailure({required this.errMessage});
}

class CreateCommentFailure extends ArtState {
  final String errMessage;

  CreateCommentFailure({required this.errMessage});
}

class GetUserFavoriteArtsLoading extends ArtState {}
