import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20in/data/repo/sign_in_repo.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInRepo) : super(SignInInitialState());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey <FormState>signInKey = GlobalKey();
  final SignInRepo signInRepo;
  void emitSignIn() async {
    emit(SignInLoadingState());
    final res = await signInRepo.signIn(
      SignInRequestModel(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    res.fold(
      (signInResponseModel) {
        emit(SignInSuccessState(signInResponseModel: signInResponseModel));
      },
      (errMessage) {
        emit(SignInFailureState(errMessage: errMessage));
      },
    );
  }
}
