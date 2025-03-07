import 'package:json_annotation/json_annotation.dart';

@JsonSerializable() ///////////////////
class SignUpResponseModel {
  String? status;

  SignUpResponseModel({required this.status});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(status: json['status']);
  }
}
