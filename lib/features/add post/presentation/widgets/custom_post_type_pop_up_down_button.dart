import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_text_form_field.dart';
import 'package:saturn/features/add%20post/logic/cubit/add_post_cubit.dart';
import 'package:saturn/features/home/data/models/category_name_and_image_model.dart';

class CustomPostTypePopUpDownButton extends StatefulWidget {
  const CustomPostTypePopUpDownButton({super.key});

  @override
  State<CustomPostTypePopUpDownButton> createState() =>
      _CustomCategoryPopUpButtonState();
}

class _CustomCategoryPopUpButtonState extends State<CustomPostTypePopUpDownButton> {
  @override
  final List<String> typList = <String>['image', 'video'];
  String? selected;
  @override
  void initState() {
    context.read<AddPostCubit>().typeController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    CustomTextFormField(
      hintText: 'add type',
      controller: context.read<AddPostCubit>().typeController,
      backgroundColor: AppColors.textformFieldColor,
        suffixIcon:      PopupMenuButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            onSelected: (value) {
              setState(() {
                context.read<AddPostCubit>().typeController.text =
                    value;
                selected = value;
              });
            },
            itemBuilder:
                (BuildContext context) =>
                    typList.map<PopupMenuItem>((item) {
                      return PopupMenuItem(
                        value: item,
                        child: Text(item),
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
