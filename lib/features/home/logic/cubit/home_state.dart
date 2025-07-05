part of 'home_cubit.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class GetAllCategorisSuccess extends HomeState {
  final List<PostModel> arts;
  GetAllCategorisSuccess({required this.arts});
}

final class GetAllCategorisFailure extends HomeState {
  final String errMessage;
  GetAllCategorisFailure({required this.errMessage});
}

final class GetAllCategorisLoading extends HomeState {}

final class GetAllUsersSuccefully extends HomeState {
  final List<UserModel> users;

  GetAllUsersSuccefully({required this.users});
}

final class GetAllUsersLoading extends HomeState {}

final class GetAllUsersFailure extends HomeState {
  final String errorMessage;

  GetAllUsersFailure({required this.errorMessage});
}

final class GetSpecificUsersSucces extends HomeState {
  final List<ChatTileModel> lastMessageModels;

  GetSpecificUsersSucces({required this.lastMessageModels});
}
