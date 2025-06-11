import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/auth/sign%20in/logic/cubit/sign_in_cubit.dart';

class CustomSignInForm extends StatefulWidget {
  const CustomSignInForm({super.key});

  @override
  State<CustomSignInForm> createState() => _CustomSignInFormState();
}

class _CustomSignInFormState extends State<CustomSignInForm> {
  bool isVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    AppFunctions.getUserData().then(
      (value) => emailController.text = value.email,
    );
    AppFunctions.getUserData().then(
      (value) => passwordController.text = value.password,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signIn = context.read<SignInCubit>();
    return Form(
      key: signIn.signInKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Email',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
            prefixIcon: Icon(Icons.email_outlined, color: AppColors.red),

            controller: emailController,
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your email',
          ),
          verticalSpace(20),
          CustomTextFormField(
            labelText: 'Password',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
            prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.red),
            controller: passwordController,
            backgroundColor: AppColors.textformFieldColor,

            hintText: 'Enter your password',

            obscureText: isVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon:
                  isVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
            ),
          ),
          verticalSpace(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  context.pushReplacementNamed(Routes.setNewPassword);
                },
                child: Text('forgot password'),
              ),
            ],
          ),
          verticalSpace(20),

          AppButton(
            title: Text('Sign In', style: AppTextstyles.font16WhiteMeduim),
            onPressed: () {
              if (signIn.signInKey.currentState!.validate()) {
                signIn.emitSignIn(
                  emailController.text,
                  passwordController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
