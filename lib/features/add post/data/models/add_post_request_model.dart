import 'dart:io';

class AddPostRequestModel {
  final String title;
  final String description;
  final String categoryName;
  final String type;
 final File? imagePath;

  AddPostRequestModel({
   required this.imagePath,
   required this.type,
    required this.title,
    required this.description,
    required this.categoryName,
  });
}