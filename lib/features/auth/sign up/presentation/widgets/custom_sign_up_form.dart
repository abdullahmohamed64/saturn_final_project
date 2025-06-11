import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';



class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key});

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final signUp = context.read<SignUpCubit>();
    return Form(
      key: signUp.signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
             labelText: 'Name',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
            controller: signUp.firstNameController,
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your name',
          ),
          verticalSpace(20),
          CustomTextFormField(
             labelText: 'Email',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
            controller: signUp.emailController,
            backgroundColor: AppColors.textformFieldColor,

            hintText: 'Enter your email',
          ),
          verticalSpace(20),

          CustomTextFormField(
             labelText: 'Password',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
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
                      ? Icon(Icons.visibility , color: AppColors.lightGrey,)
                      : Icon(Icons.visibility_off , color: AppColors.lightGrey,),
            ),
          ),
          verticalSpace(20),
          CustomTextFormField(
             labelText: 'Confirm Password',
            labelTextStyle: AppTextstyles.font14BlackMeduim,
            controller: signUp.confirmPasswordController,
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
                      ? Icon(Icons.visibility , color: AppColors.lightGrey,)
                      : Icon(Icons.visibility_off , color: AppColors.lightGrey,),
            ),
          ),

          verticalSpace(30),

          AppButton(
            onPressed: (){
              if(signUp.passwordController.text == signUp.confirmPasswordController.text){
                context.pushNamed(Routes.completeProfile);
              }
              else {
                ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('passwords do not match')));
              }
            },
            title: Text('Continue', style: AppTextstyles.font16WhiteMeduim),
          ),
        ],
      ),
    );
  }
}
