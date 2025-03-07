import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignInResponseModel {
  final String username;
  final String email;
  final String password;
  final String mobile;
  final String birthdate; // Corrected spelling
  final String gender;
  final String bio;

  final File imagePath;

  SignInResponseModel({
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.birthdate,
    required this.gender,
    required this.bio,
    required this.imagePath,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      mobile: json['mobile'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      bio: json['bio'],
      imagePath: File(json['file']),
    );
  }
}
