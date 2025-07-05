import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saturn/core/di/dependency_injection.dart';

import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_response_model.dart';
import 'package:saturn/features/auth/sign%20up/data/repo/sign_up_repo.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpRepo) : super(SignUpInitial());
  final SignUpRepo _signUpRepo;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  File? image;
  TextEditingController genderController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final GlobalKey<FormState> completeProfileformKey = GlobalKey();

  void emitSignUp() async {
    emit(SignUpLoading());
    String userName = '${firstNameController.text} ${lastNameController.text}';

    final res = await _signUpRepo.signUp(
      SignUpRequestModel(
        username: userName,
        email: emailController.text,
        password: passwordController.text,
        mobile: mobileController.text,
        birthdate: birthDateController.text,
        gender: genderController.text,
        bio: bioController.text,
        imagePath: image,
      ),
    );
    
    res.fold((signUpResponseModel) async {
       SharedPrefHelper().setSecuredData(
        SharedPrefKeys.tokenKey,
        signUpResponseModel.token ?? 'no token',
      );
      await AppFunctions.saveUserData(
        email: signUpResponseModel.userData?.email ?? 'no email',
        password: signUpResponseModel.userData?.password ?? 'no password',
      );
      await getIt <SharedPrefHelper>().setData(
        SharedPrefKeys.userIdKey,
        signUpResponseModel.userData?.id ?? '',
      );
      ChatService().saveFCMToken(signUpResponseModel.userData?.id.toString() ?? '');

      emit(SignUpSuccess(signUpResponseModel: signUpResponseModel));
    }, (error) => emit(SignUpError(error)));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    birthDateController.dispose();

    genderController.dispose();
    bioController.dispose();
    return super.close();
  }

  void pickImageAndUpload() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ImageUploaded(image: image!));
    }
  }
}
