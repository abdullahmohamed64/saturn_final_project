part of 'home_cubit.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class GetAllCategorisSuccess extends HomeState {
  final List<ArtModel> arts;
  GetAllCategorisSuccess({required this.arts});
}

final class GetAllCategorisFailure extends HomeState {
  final String errMessage;
  GetAllCategorisFailure({required this.errMessage});
}

final class GetAllCategorisLoading extends HomeState {}
