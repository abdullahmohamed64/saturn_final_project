import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/profile/logic/edit%20user%20cubit/edit_user_profile_cubit.dart';
import 'package:saturn/features/profile/presentaion/widgets/edit_profile_form.dart';
import 'package:saturn/features/profile/presentaion/widgets/edit_user_bloc_listener.dart';
import 'package:saturn/features/profile/presentaion/widgets/user_image.dart';

class EditUserProfileView extends StatelessWidget {
  const EditUserProfileView({super.key, required this.userModel});
  final UserModel userModel ;
  @override
  Widget build(BuildContext context) {
    final editCubit = context.watch<EditUserProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (editCubit.formKey.currentState!.validate()) {
                editCubit.editUserProfile();
                // context.read<UserProfileCubit>().emitGetUserProfile();

                // context.pop();
              }
            },
            child: const Text("Save", style: TextStyle(color: AppColors.white)),
          ),
        ],
        backgroundColor: AppColors.appBarColorPurple,
        toolbarHeight: 138.h,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.arrowBackBakgroundColor,
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.arrowBackColor,
            ),
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      backgroundColor: AppColors.appBarColorPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 800.h,
            // margin: EdgeInsets.only(top: 130.h),
            decoration: BoxDecoration(
              color: AppColors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: Column(
              children: [
                verticalSpace(20),
                GestureDetector(
                  onTap: () {
                    editCubit.pickImageAndUpload();
                  },
                  child: Stack(
                    children: [
                      UserImage(user: userModel, editCubit: editCubit),
                      //edit pin
                      Positioned(
                        bottom: 70.h,
                        right: -2.w,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: AppColors.white,
                          child: Image.asset(Assets.assetsImagesEditPin, fit: BoxFit.contain,),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomEditProfileForm(),

                EditUserBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
