class AddPostResponseModel {
  final String status;
  final String message;

  AddPostResponseModel({required this.status, required this.message});
  factory AddPostResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPostResponseModel(status: json['status'], message: json['message']);
}
