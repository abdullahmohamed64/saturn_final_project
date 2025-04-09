import 'package:saturn/features/auth/models/user_model.dart';

class UsersListModel {
  final String status ;
  final List<UserModel>? users;

  UsersListModel({required this.status, required this.users});
  
factory UsersListModel.fromJson(Map<String , dynamic> json){
  List<UserModel> users1 = [];
  for (var user in json['users']){
    users1.add(UserModel.fromJson(user));
  }
  return UsersListModel(status: json['status'], users: users1);
}
}