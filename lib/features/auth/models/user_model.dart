import 'dart:io';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? token;
  final String? createdAt;
  final String? mobile;
  final String? birthDate;
  final String? picName;
  final String? gender;
  final String? bio;
  final File? imagePath;

  UserModel( {
    this.id,
    this.username,
    this.email,
    this.password,
    this.token,
    this.createdAt,
    this.mobile,
    this.birthDate,
    this.picName,
    this.gender,
    this.bio,
    this.imagePath,
    
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
      createdAt: json['created_at'],
      mobile: json['mobile'],
      birthDate: json['birth_date'],
      picName: json['pic_name'],
      gender: json['gender'],
      bio: json['bio'],
    );
}
}

// "status": "success",
//     "data": [
//         {
//             "id": 4,
//             "username": "aaabbb4",
//             "email": "aaabbbb4@gmail.com",
//             "password": "123456",
//             "token": null,
//             "created_at": "2025-03-07 13:49:36",
//             "mobile": "01234222",
//             "birth_date": "2002-12-01",
//             "pic_name": "fail",
//             "gender": "male",
//             "bio": "b"
//         }
//     ]