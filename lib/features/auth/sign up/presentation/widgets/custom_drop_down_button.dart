import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';

const List<String> list = <String>['male', 'female'];

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String dropdownValue = list[0];
  late TextEditingController genderController;

  @override
  void initState() {
    genderController = context.read<SignUpCubit>().genderController;
    genderController.text = 'male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      elevation: 4,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.theMostlightGrey,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.theMostlightGrey,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(
            color: AppColors.theMostlightGrey,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: AppColors.theMostlightGrey,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          genderController.text = value;
        });
      },
      items:
          list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Icon(
                    value == 'male' ? Icons.male : Icons.female,
                    color: AppColors.grey,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    value,
                    style: AppTextstyles.font14LigtGreyRegular.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
