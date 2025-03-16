import 'package:saturn/features/home/data/models/art_model.dart';

class UserFavouritArtsModel {
  List<ArtModel> arts;

  UserFavouritArtsModel({required this.arts});
  factory UserFavouritArtsModel.fromJson(Map<String, dynamic> json) {
    return UserFavouritArtsModel(
      arts: List<ArtModel>.from(json["data"].map((x) => ArtModel.fromJson(x))),
    );
  }
}
