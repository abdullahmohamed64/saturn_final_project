part of 'user_profile_cubit_.dart';

class UserProfileCubitState {}

final class UserProfileCubitInitial extends UserProfileCubitState {}

final class UserProfileCubitLoading extends UserProfileCubitState {}

final class UserProfileCubitSuccesfully extends UserProfileCubitState {
  final UserProfileResponseModel userProfileResponseModel;
  UserProfileCubitSuccesfully({required this.userProfileResponseModel});
}

final class UserProfileCubitFailure extends UserProfileCubitState {
  final String message;
  UserProfileCubitFailure({required this.message});
}
