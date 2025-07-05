import 'package:saturn/features/home/data/models/art_model.dart';

class UserFavouritArtsModel {
  List<PostModel> arts;

  UserFavouritArtsModel({required this.arts});
  factory UserFavouritArtsModel.fromJson(Map<String, dynamic> json) {
    return UserFavouritArtsModel(
      arts: List<PostModel>.from(
        json["data"].map((x) => PostModel.fromJson(x)),
      ),
    );
  }
}
