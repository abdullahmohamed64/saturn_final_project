
import 'package:saturn/core/helper/app_reg_exp.dart';
import 'package:saturn/core/helper/extension.dart';

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

  // static Future<void> saveUserData(String email, password) async {
  //   await SharedPrefHelper.setData(SharedPrefKeys.emailKey, email);
  //   await SharedPrefHelper.setSecuredData(SharedPrefKeys.passwordKey, password);
  // }

  // static Future<LoginRequestBodyModel> getUserData() async {
  //   final email = await SharedPrefHelper.getString(SharedPrefKeys.emailKey);
  //   final password =
  //       await SharedPrefHelper.getSecuredData(SharedPrefKeys.passwordKey);
  //   return LoginRequestBodyModel(email: email, password: password);
  // }

   
}

  
