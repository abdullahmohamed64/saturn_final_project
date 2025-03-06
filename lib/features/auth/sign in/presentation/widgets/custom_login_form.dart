import 'package:flutter/material.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';

class CustomLoginForm extends StatefulWidget {
  const CustomLoginForm({super.key});

  @override
  State<CustomLoginForm> createState() => _CustomLoginFormState();
}

class _CustomLoginFormState extends State<CustomLoginForm> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your email',
          ),
          verticalSpace(20),
          CustomTextFormField(
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
                onTap: (){
                  context.pushReplacementNamed(Routes.setNewPassword);
                },
                child: Text('forgot password'))
              
              ]
              ),
          verticalSpace(20),

          AppButton(
            title: Text('Sign In', style: AppTextstyles.font16WhiteMeduim),
          ),
        ],
      ),
    );
  }
}
