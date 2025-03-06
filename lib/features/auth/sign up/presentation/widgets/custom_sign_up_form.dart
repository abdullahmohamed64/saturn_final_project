import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/auth/sign%20in/presentation/views/sign_in_page.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';



class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key});

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final signUp = context.read<SignUpCubit>();
    return Form(
      key: signUp.signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: signUp.firstNameController,
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your name',
          ),
          verticalSpace(20),
          CustomTextFormField(
            controller: signUp.emailController,
            backgroundColor: AppColors.textformFieldColor,

            hintText: 'Enter your email',
          ),
          verticalSpace(20),

          CustomTextFormField(
            controller: signUp.passwordController,

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
          verticalSpace(20),
          CustomTextFormField(
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'confirm password',
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

          verticalSpace(30),

          AppButton(
            onPressed: (){
              context.pushNamed(Routes.completeProfile);
            },
            title: Text('Continue', style: AppTextstyles.font16WhiteMeduim),
          ),
        ],
      ),
    );
  }
}
