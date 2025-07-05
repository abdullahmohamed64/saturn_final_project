


import 'package:saturn/features/auth/sign%20in/data/models/sign_in_response_model.dart';

abstract class SignInState {

}
class SignInInitialState extends SignInState{}
class SignInSuccessState extends SignInState{
final SignInResponseModel signInResponseModel ;

  SignInSuccessState({required this.signInResponseModel});

}

class SignInFailureState extends SignInState{
final String errMessage ;

  SignInFailureState({required this.errMessage});

}

class SignInLoadingState extends SignInState{}