part of 'edit_user_profile_cubit.dart';

 class EditUserProfileState {}

class EditUserProfileInitial extends EditUserProfileState {}
class EditUserProfilSuccess extends EditUserProfileState {
  final String message;

  EditUserProfilSuccess({required this.message});
}

class EditUserProfileLoading extends EditUserProfileState {}
class EditUserProfileFailure extends EditUserProfileState {
    final String errMessage;

  EditUserProfileFailure({required this.errMessage});
}
class ImageUploaded extends EditUserProfileState{
  final File image;
  ImageUploaded({required this.image});
}


