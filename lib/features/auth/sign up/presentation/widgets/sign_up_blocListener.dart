import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          Center(child: CircularProgressIndicator());
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content:
          
           Text('sign up failed ${state.message}')));
        } else if(state is ImageUploaded){
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('image uploaded succesfully')));
        }
        else{
          context.pushReplacementNamed(Routes.loginSuccefullyPage);
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
