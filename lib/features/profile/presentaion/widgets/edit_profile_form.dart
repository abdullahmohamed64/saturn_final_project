import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/profile/logic/edit%20user%20cubit/edit_user_profile_cubit.dart';

class CustomEditProfileForm extends StatefulWidget {
  const CustomEditProfileForm({super.key});

  @override
  State<CustomEditProfileForm> createState() => _CustomEditProfileFormState();
}

class _CustomEditProfileFormState extends State<CustomEditProfileForm> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditUserProfileCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: editCubit.formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170.w,
                  child: CustomTextFormField(
                    // height: 80.h,
                    labelText: 'First name',
                    horizontalPadding: 5,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        Assets.assetsImagesUsername,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                    controller: editCubit.firstNameController,
                    hintText: 'Mohamed',
                  ),
                ),
                SizedBox(
                  width: 170.w,
                  child: CustomTextFormField(
                    // height: 80.h,
                    labelText: 'Last name',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        Assets.assetsImagesUsername,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                    controller: editCubit.lastNameController,
                    hintText: 'Ahmed',
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170.w,
                  child: CustomTextFormField(
                    // height: 80.h,
                    labelText: 'phone number',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        Assets.assetsImagesPhone,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                    hintText: '01273904441',
                  ),
                ),
                SizedBox(
                  width: 170.w,
                  child: CustomTextFormField(
                    // height: 80.h,
                    labelText: 'birthdate',
                    controller: editCubit.birthdateController,
                    prefixIcon: IconButton(
                      onPressed: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime(2002),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2015),
                        ).then(
                          (value) =>
                              editCubit.birthdateController.text = DateTime(
                                value!.year,
                                value.month,
                                value.day,
                              ).toIso8601String().substring(0, 10),
                        );
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.red,
                      ),
                    ),
                    hintText: 'date birth',
                  ),
                ),
              ],
            ),

            verticalSpace(10),
            CustomTextFormField(
              // height: 73,
              labelText: 'Email',
              controller: editCubit.emailController,
              prefixIcon: Icon(Icons.email_outlined , color: AppColors.red,size: 28.sp,),
              hintText: 'examble@gmail.com',
            ),
            verticalSpace(10),
            CustomTextFormField(
              obscureText: !isVisible,
              // height: 88.h,
              suffixIcon:IconButton(onPressed: (){
                isVisible = !isVisible;
                setState(() {
                  
                });
              }, icon: Icon(
                
               isVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.lightGrey,)
               
               ) ,
              labelText: 'Password',
              controller: editCubit.passwordController,
              prefixIcon: Icon(Icons.lock_outlined , color: AppColors.red,size: 28.sp,),
              
            ),

            verticalSpace(10),
            CustomTextFormField(
              maxLines: 2,
              // height: 140.h,
              labelText: 'Bio',
              controller: editCubit.bioController,
            ),
          ],
        ),
      ),
    );
  }
}
