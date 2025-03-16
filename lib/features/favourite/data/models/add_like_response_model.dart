class AddLikeResponseModel {
  //liked or remove like
  final String message;
  bool isLiked;
  AddLikeResponseModel({required this.message, required this.isLiked});
  factory AddLikeResponseModel.fromJson(Map<String, dynamic> json) {
    bool like;
    if (json['message'] == 'Like removed') {
      like = false;
    } else {
      like = true;
    }
    return AddLikeResponseModel(message: json['message'], isLiked: like);
  }
}
