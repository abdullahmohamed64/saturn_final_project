import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response_model.g.dart';

@JsonSerializable()///////////////////
class SignUpResponseModel {
   String? status;

  SignUpResponseModel({required this.status});

  factory  SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);
}
