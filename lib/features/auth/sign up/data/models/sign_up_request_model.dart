import 'dart:io';



/// A custom JsonConverter that converts a File to/from its file path.
// class FileConverter implements JsonConverter<File, String> {
//   const FileConverter();

//   @override
//   File fromJson(String json) => File(json);

//   @override
//   String toJson(File object) => object.path;
// }


class SignUpRequestModel {
  final String username;
  final String email;
  final String password;
  final String mobile;
  final String birthdate;
  final String gender;
  final String? bio;



  final File? imagePath;

  SignUpRequestModel({
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.birthdate,
    required this.gender,
     this.bio,
     this.imagePath,
  });


}
