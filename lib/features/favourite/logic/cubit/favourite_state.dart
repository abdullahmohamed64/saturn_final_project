part of 'favourite_cubit.dart';

abstract class FavoriteState {}

class FavouriteInitial extends FavoriteState {}

class ReactedSuccefully extends FavoriteState {
  final FavoriteModel favouriteRsponseModel;

  ReactedSuccefully({required this.favouriteRsponseModel});
}

class ReactedFailure extends FavoriteState {
  final String errMessage;

  ReactedFailure({required this.errMessage});
}

class ReactedLoading extends FavoriteState {}
