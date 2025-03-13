part of 'favourite_cubit.dart';

abstract class FavoriteState {}

class FavouriteInitial extends FavoriteState {}

class ReactedSuccefully extends FavoriteState {
  final AddLikeResponseModel addLikeResponseModel;

  ReactedSuccefully({required this.addLikeResponseModel});
}

class ReactedFailure extends FavoriteState {
  final String errMessage;

  ReactedFailure({required this.errMessage});
}

class ReactedLoading extends FavoriteState {}
