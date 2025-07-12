import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:saturn/features/add%20post/data/models/add_post_request_model.dart';
import 'package:saturn/features/add%20post/data/models/add_post_response_model.dart';
import 'package:saturn/features/add%20post/data/repo/add_post_repo.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._addPostRepo) : super(AddPostInitial());
  final AddPostRepo _addPostRepo;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();

  final GlobalKey<FormState> addPostFormKey = GlobalKey();
  File? image;

  void emitAddPost() async {
    emit(AddPostLoading());
    final res = await _addPostRepo.addPost(
      AddPostRequestModel(
        type: typeController.text,
        imagePath: image,
        title: titleController.text,
        description: descriptionController.text,
        categoryName: categoryNameController.text,
      ),
    );
    res.fold(
      (l) {
        emit(AddPostFailure(errMessage: l));
      },
      (r) {
        emit(AddPostSuccefully(r));
      },
    );
  }

  void pickImageAndUpload() async {
    emit(AddImageLoading());
    try {
      XFile? pickImage =  await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      image = File(pickImage!.path);
      emit(AddImageSuccefully(image: image!));
    } catch (e) {
      emit(AddImageFailure(errMessage: e.toString()));
    }
  }

    void pickVideoAndUpload() async {
    emit(AddImageLoading());
    try {
      XFile? pickImage = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );

      image = File(pickImage!.path);
      emit(AddImageSuccefully(image: image!));
    } catch (e) {
      emit(AddImageFailure(errMessage: e.toString()));
    }
  }
}
