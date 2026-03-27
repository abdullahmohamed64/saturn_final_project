part of 'add_post_cubit.dart';

class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostSuccefully extends AddPostState {
  final AddPostResponseModel addPostResponseModel;
  AddPostSuccefully(this.addPostResponseModel);
}

final class AddPostFailure extends AddPostState {
  final String errMessage;

  AddPostFailure({required this.errMessage});
}
final  class AddImageLoading extends AddPostState{}
final  class AddImageFailure extends AddPostState{
  final String errMessage;

  AddImageFailure({required this.errMessage});

}
final  class AddImageSuccefully extends AddPostState{
final File image;

  AddImageSuccefully({required this.image});

}
