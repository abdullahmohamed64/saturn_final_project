part of 'get_user_favorite_arts_cubit.dart';

class GetUserFavoriteArtsState {}

class GetUserFavoriteArtsInitial extends GetUserFavoriteArtsState {}

class GetUserFavoriteArtsLoading extends GetUserFavoriteArtsState {}

class GetUserFavoriteArtsSucces extends GetUserFavoriteArtsState {
  final List<PostModel> arts;

  GetUserFavoriteArtsSucces({required this.arts});
}

class GetUserFavoriteArtsFailure extends GetUserFavoriteArtsState {
  final String errMessage;

  GetUserFavoriteArtsFailure({required this.errMessage});
}
