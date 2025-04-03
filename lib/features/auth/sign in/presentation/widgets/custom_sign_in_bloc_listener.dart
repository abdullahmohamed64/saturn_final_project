import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_cubit.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_state.dart';

class CustomSignInBlocListener extends StatelessWidget {
  const CustomSignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          Center(child: CircularProgressIndicator());
        } else if (state is SignInFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('sign in failed ${state.errMessage}')),
          );
        } else if (state is SignInSuccessState) {
          context.pushNamedAndRemoveUntile(
            Routes.loginSuccefullyPage,
            predicate: (_) => false,
          );
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
