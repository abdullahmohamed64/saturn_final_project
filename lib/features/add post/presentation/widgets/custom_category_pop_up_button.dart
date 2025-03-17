import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';
import 'package:saturn/features/home/data/models/category_name_and_image_model.dart';

class CustomCategoryPopUpButton extends StatefulWidget {
  const CustomCategoryPopUpButton({super.key});

  @override
  State<CustomCategoryPopUpButton> createState() =>
      _CustomCategoryPopUpButtonState();
}

class _CustomCategoryPopUpButtonState extends State<CustomCategoryPopUpButton> {
  @override
  String? selected;
  @override
  void initState() {
    context.read<AddPostCubit>().categoryNameController ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: context.read<AddPostCubit>().categoryNameController,
      hintText: 'classification',
      suffixIcon: PopupMenuButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        onSelected: (value) {
          setState(() {
            context.read<AddPostCubit>().categoryNameController.text = value;
            selected = value;
          });
        },
        itemBuilder:
            (BuildContext context) =>
                categories.map<PopupMenuItem>((category) {
                  return PopupMenuItem(
                    value: category.categoryName,
                    child: Text(category.categoryName),
                  );
                }).toList(),
        child: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: AppColors.addPostInputTextsColor,
        ),
      ),
    );
  }
}
