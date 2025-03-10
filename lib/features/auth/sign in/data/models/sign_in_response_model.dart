import 'package:saturn/features/auth/models/user_model.dart';

class SignInResponseModel {
  final String? status;
  final UserModel? userData;
  final String? token;
  SignInResponseModel({this.status, this.userData, this.token});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    // List<UserModel> data = [];
    // for (var element in json['data']) {
    //   data.add(UserModel.fromJson(element));
    // }

    UserModel userModel = UserModel.fromJson(json['data']);
    return SignInResponseModel(
      status: json['status'],
      userData: userModel,
      token: json['token'],
    );
  }
}


// {
//     "status": "success",
//     "data": 
//         {
//             "id": 4,
//             "username": "aaabbb4",
//             "email": "aaabbbb45@gmail.com",
//             "password": "123456",
//             "token": null,
//             "created_at": "2025-03-07 14:11:28",
//             "mobile": "012342221",
//             "birth_date": "2002-12-01",
//             "pic_name": "9399android_logo.png",
//             "gender": "male",
//             "bio": "b"
//         }
//     
// }