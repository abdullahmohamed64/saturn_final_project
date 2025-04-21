import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/app_button.dart';
import 'package:saturn/core/widgets/custom_listview_shimmer.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';
import 'package:saturn/features/add%20post/presentation/widgets/choose_img_or_video.dart';
import 'package:saturn/features/add%20post/presentation/widgets/custom_category_pop_up_button.dart';
import 'package:saturn/features/add%20post/presentation/widgets/custom_post_type_pop_up_down_button.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addPostCubit = context.read<AddPostCubit>();
    return Scaffold(
      backgroundColor: AppColors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AddPostCubit, AddPostState>(
            listener: (context, state) {
              listener(state, context);
            },
            builder: (context, state) {
              return state is AddPostLoading
                  ? CustomListViewShimmer()
                  : Form(
                    key: addPostCubit.addPostFormKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpace(20),
                            CustomTextFormField(
                              controller: addPostCubit.descriptionController,
                              hintText: 'descrption',
                              hintTextStyle: AppTextstyles.font14GreyRegular
                                  .copyWith(
                                    color: AppColors.addPostInputTextsColor,
                                  ),
                            ),
                            verticalSpace(20),

                            CustomCategoryPopUpButton(),
                            verticalSpace(20),
                            CustomPostTypePopUpDownButton(),
                            verticalSpace(20),
                            ChooseImageOrVideoWidget(),
                            verticalSpace(80),
                            AppButton(
                              height: 80.h,
                              width: double.infinity,
                              // backgroungColor: AppColors.theMostLighPurple,
                              title: buildDoneTitleButton(
                                State is AddImageLoading,
                              ),

                              onPressed: () {
                                if (addPostCubit.addPostFormKey.currentState!
                                        .validate() &&
                                    addPostCubit.image != null &&
                                    !addPostCubit.categoryNameController.text
                                        .isNullOrEmpty()) {
                                  addPostCubit.emitAddPost();
                                } else {
                                  AppFunctions.showCustomDialog(
                                    context,
                                    'error',
                                    'fill all fields',
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }

  Widget buildDoneTitleButton(bool isLoading) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Text(
          'Done',
          style: AppTextstyles.font16WhiteMeduim.copyWith(
            color: AppColors.white,
          ),
        );
  }

  void listener(AddPostState state, BuildContext context) {
    if (state is AddPostSuccefully) {
      AppFunctions.showCustomDialog(
        context,
        'success',
        'post added successfully',
      );
      context.read<HomeCubit>().getCategoyItems();
      context.pushNamedAndRemoveUntile(
        Routes.navigationPage,
        predicate: (context) => false,
      );
    } else if (state is AddPostFailure) {
      AppFunctions.showCustomDialog(context, 'error', state.errMessage);
    }
  }
}
