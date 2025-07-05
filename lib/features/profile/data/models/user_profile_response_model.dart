import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class UserProfileResponseModel {
  final String? status;
  final UserModel? user;
  final List<PostModel>? arts;

  UserProfileResponseModel({
    required this.status,
    required this.user,
    required this.arts,
  });
  UserProfileResponseModel.fromJson(Map<String, dynamic> json)
    : status = json['status'],
      user =
          json['user_information'] != null
              ? UserModel.fromJson(json['user_information'])
              : null,
      arts =
          json['posts'] != null
              ? (json['posts'] as List)
                  .map((i) => PostModel.fromJson(i))
                  .toList()
              : null;
}
