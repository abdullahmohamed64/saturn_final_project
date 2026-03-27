part of 'sign_up_cubit.dart';


abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
final class SignUpSuccess extends SignUpState {
  final SignUpResponseModel  signUpResponseModel;

  SignUpSuccess({required this.signUpResponseModel});
}

final class ImageUploaded extends SignUpState {

  final File image;

  ImageUploaded({required this.image});
}

