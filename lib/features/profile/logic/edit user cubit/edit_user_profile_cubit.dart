import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/auth/sign%20up/presentation/widgets/upload_image_tp_api.dart';
import 'package:saturn/features/profile/data/repo/edit_user_repo.dart';

part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileState> {
  final EditUserRepo _editUserRepo;
  EditUserProfileCubit(this._editUserRepo) : super(EditUserProfileInitial());
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController mobileController = TextEditingController(text: '');
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController bioController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController birthdateController = TextEditingController(text: '');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? image;
  editUserProfile() async {
    final res = await _editUserRepo.editUserProfile(
      UserModel(
        username: '${firstNameController.text} ${lastNameController.text}',
        email: emailController.text,
        password: passwordController.text,
        birthDate: birthdateController.text,
        bio: bioController.text,
        imagePath: image
      ),
    );
    res.fold(
      (errMessage) {
        emit(EditUserProfileFailure(errMessage: errMessage));
      },
      (editRes) {
        emit(EditUserProfilSuccess(message: editRes.message));
      },
    );
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
