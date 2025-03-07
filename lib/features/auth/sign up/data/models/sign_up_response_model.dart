import 'package:saturn/features/auth/models/user_model.dart';

class SignUpResponseModel {
  final String? status;
  final UserModel? data;
  final String? token;
  SignUpResponseModel({required this.status, this.data, this.token});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    UserModel userModel = UserModel.fromJson(json['data']);
    return SignUpResponseModel(
      status: json['status'],
      data: userModel,
      token: json['token'],
    );
  }
}
