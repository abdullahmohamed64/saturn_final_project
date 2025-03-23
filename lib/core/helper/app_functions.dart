import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saturn/core/helper/app_reg_exp.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/shared_pref_helper.dart';
import 'package:saturn/core/helper/shared_pref_keys.dart';
import 'package:saturn/core/networking/api_error_model.dart';
import 'package:saturn/core/networking/server_exception.dart';
import 'package:saturn/features/auth/sign%20in/data/models/sign_in_request_model.dart';
import 'package:saturn/features/auth/sign%20up/data/models/sign_up_request_model.dart';

class AppFunctions {
  String? checkEmailValidation(value) {
    if (!AppRegExp().isValidEmail(value) || value == null || value?.isEmpty ??
        true) {
      return 'enter valid email';
    }
    return null;
  }

  String? checkPhoneNumberValidation(String value) {
    if (!AppRegExp().isPhoneNumber(value) || value.isNullOrEmpty()) {
      return 'enter valid phone number ';
    }
    return null;
  }

  // static Future<void> saveUserToken({required String token}) async {
  //   await SharedPrefHelper.setSecuredData(SharedPrefKeys.userTokenKey, token);
  //   // DioFactory.addTokenAfterLogin(token: token);
  // }

  // static List<DoctorModel?>? searchDoctors(
  //     {required List<DoctorModel> doctors, required String doctorName}) {
  //   if (doctors.isNullOrEmpty()) return <DoctorModel?>[];

  //   return doctors
  //       .where((DoctorModel doctor) =>
  //           doctor.name?.toLowerCase().contains(doctorName.toLowerCase()) ??
  //           false)
  //       .toList();

  //   // return doctors
  //   //     .where((DoctorModel doctor) =>
  //   //         doctor.name?.toLowerCase().startsWith(doctorName.toLowerCase()) ??
  //   //         false)
  //   //     .toList();
  // }

  static Future<void> saveUserData({required String email, password}) async {
    await SharedPrefHelper.setData(SharedPrefKeys.emailKey, email);
    await SharedPrefHelper.setSecuredData(SharedPrefKeys.passwordKey, password);
  }

  static Future<SignInRequestModel> getUserData() async {
    final email = await SharedPrefHelper.getString(SharedPrefKeys.emailKey);
    final password = await SharedPrefHelper.getSecuredData(
      SharedPrefKeys.passwordKey,
    );
    return SignInRequestModel(email: email, password: password);
  }

  static void handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      case DioExceptionType.sendTimeout:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );
      case DioExceptionType.receiveTimeout:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      case DioExceptionType.badCertificate:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      case DioExceptionType.badResponse:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      case DioExceptionType.cancel:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      case DioExceptionType.connectionError:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );

      default:
        throw ServerException(
          apiErrorModel: ApiErrorModel.fromJson(e.response!.data),
        );
    }
  }

  static Future<MultipartFile> uploadImageToApiMethod(File? imagePath) =>
      MultipartFile.fromFile(
        imagePath?.path ?? '',
        filename: imagePath?.path.split('/').last ?? '',
      );

  static void showCustomDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

 static  String formatDate(String createdAt) {
    final DateTime parsedDate = DateTime.parse(createdAt);
    return DateFormat('MMM d • h:mm a').format(parsedDate);
  }
}
