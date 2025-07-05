import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:saturn/core/di/dependency_injection.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20in/data/repo/sign_in_repo.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_state.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInRepo) : super(SignInInitialState());

  final GlobalKey<FormState> signInKey = GlobalKey();
  final SignInRepo signInRepo;
  void emitSignIn(String email, String password) async {
    emit(SignInLoadingState());

    final res = await signInRepo.signIn(
      SignInRequestModel(email: email, password: password),
    );

    res.fold(
      (signInResponseModel) async {
         SharedPrefHelper().setSecuredData(
          SharedPrefKeys.tokenKey,
          signInResponseModel.token ?? 'no token',
        );

        await AppFunctions.saveUserData(
          email: signInResponseModel.userData?.email ?? 'no email',
          password: signInResponseModel.userData?.password ?? 'no password',
        );
        await getIt<SharedPrefHelper>() .setData(
          SharedPrefKeys.userIdKey,
          signInResponseModel.userData?.id ?? '',
        );
        ChatService().saveFCMToken(
          signInResponseModel.userData?.id.toString() ?? '',
        );

        emit(SignInSuccessState(signInResponseModel: signInResponseModel));
      },
      (errMessage) {
        emit(SignInFailureState(errMessage: errMessage));
      },
    );
  }
}
