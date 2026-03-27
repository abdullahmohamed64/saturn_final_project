import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.label,
    this.maxLines,
    this.suffixIcon,
    this.enabledBorderColor,
    this.focusdBorderColor,
    this.enabledBorder,
    this.focusedBorder,
    this.horizontalPadding,
    this.hintTextStyle,
    this.suffixIconColor,
    this.backgroundColor,
    this.obscureText,
    this.verticalPadding,
    this.borderRadius,
    this.controller,
    this.checkValidation, this.width, this.prefixIcon,
  });

  /// The text to be displayed as a hint in the text form field.
  final String hintText;

  final Widget? suffixIcon;
  final Color? enabledBorderColor;
  final Color? focusdBorderColor;
  final double? enabledBorder;
  final double? focusedBorder;
  final double? horizontalPadding;
  final double? verticalPadding;
  final TextStyle? hintTextStyle;
  final Color? suffixIconColor;
  final Color? backgroundColor;
  final bool? obscureText;
  final double? borderRadius;
  final TextEditingController? controller;
  final String? Function(String?)? checkValidation;
  final Widget? label;
  final double? width;
  final int? maxLines;
  final Icon? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w,
      child: TextFormField(
        maxLines: maxLines ?? 1,
        
        controller: controller,
        validator: checkValidation ?? defaultCheckValidation,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor ?? AppColors.morelightGrey,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusdBorderColor ?? AppColors.mainBlue,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 16.sp),
          ),
          errorBorder: customErrorBorder(),
          focusedErrorBorder: customErrorBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 17.w,
            vertical: verticalPadding ?? 20.h,
          ),
          hintText: hintText,
          hintStyle: hintTextStyle ?? AppTextstyles.font12LigtGreyRegular,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: backgroundColor ?? AppColors.theMostlightGrey,
          label: label,
        ),
        obscureText: obscureText ?? false,
      ),
    );
  }

  String? defaultCheckValidation(value) {
    if (value.toString().isNullOrEmpty()) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  OutlineInputBorder customErrorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );
  }
}
