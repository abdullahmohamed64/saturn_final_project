import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';

import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';
import 'package:saturn/features/auth/sign%20up/presentation/widgets/custom_drop_down_button.dart';
import 'package:saturn/features/auth/sign%20up/presentation/widgets/upload_image_tp_api.dart';

class CustomCompleteProfileForm extends StatefulWidget {
  const CustomCompleteProfileForm({super.key});

  @override
  State<CustomCompleteProfileForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomCompleteProfileForm> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final signUp = context.read<SignUpCubit>();
    return Form(
      key: signUp.completeProfileformKey,
      child: Column(
        children: [
          verticalSpace(20),
          PickImageAndUploadToApi(signUp: signUp),
          verticalSpace(40),

          CustomTextFormField(
            controller: signUp.firstNameController,
            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your first name',
          ),
          verticalSpace(20),
          CustomTextFormField(
            controller: signUp.lastNameController,
            backgroundColor: AppColors.textformFieldColor,

            hintText: 'Enter your last name',
          ),
          verticalSpace(20),

          CustomTextFormField(
            controller: signUp.mobileController,

            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Enter your phone number',
          ),
          verticalSpace(20),

          //gender
          CustomDropDownButton(),
          verticalSpace(20),

          //birthdate
          //create birth date item using date package
          CustomTextFormField(
            suffixIcon: IconButton(
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime(2002),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2015),
                ).then(
                  (value) =>
                      signUp.birthDateController.text =
                          DateTime(
                            value!.year,
                            value.month,
                            value.day,
                          ).toString(),
                );
              },
              icon: Icon(Icons.calendar_today),
            ),
            hintText: 'birth date',
            controller: signUp.birthDateController,
          ),

          verticalSpace(20),
          CustomTextFormField(
            maxLines: 4,
            controller: signUp.bioController,

            backgroundColor: AppColors.textformFieldColor,
            hintText: 'Bio',
          ),

          verticalSpace(30),

          AppButton(
            onPressed: () {
              if (signUp.completeProfileformKey.currentState!.validate() &&
                  signUp.signUpFormKey.currentState!.validate()) {
                signUp.emitSignUp();
              }
            },
            title: Text('sign up', style: AppTextstyles.font16WhiteMeduim),
          ),
        ],
      ),
    );
  }
}
