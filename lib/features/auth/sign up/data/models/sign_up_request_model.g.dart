// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestModel _$SignUpRequestModelFromJson(Map<String, dynamic> json) =>
    SignUpRequestModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      mobile: json['mobile'] as String,
      birthdate: json['birthdate'] as String,
      gender: json['gender'] as String,
      bio: json['bio'] as String,
      imagePath: const FileConverter().fromJson(json['file'] as String),
    );

Map<String, dynamic> _$SignUpRequestModelToJson(SignUpRequestModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'mobile': instance.mobile,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'bio': instance.bio,
      'file': const FileConverter().toJson(instance.imagePath),
    };
