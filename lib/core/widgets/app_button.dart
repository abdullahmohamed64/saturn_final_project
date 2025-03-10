import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.borderRadius,
    this.verticalPadding,
    this.horizontalPadding,
    this.backgroungColor,
    this.titleStyle,
    this.width,
    this.height,
    this.onPressed,
  });
  final Widget title;
  final double? borderRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? backgroungColor;
  final TextStyle? titleStyle;
  final double? width;
  final double? height;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 16.w,
            vertical: verticalPadding ?? 20.h,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroungColor ?? AppColors.mainPurple,
        ),
        minimumSize: WidgetStateProperty.all(
          Size(width ?? 325.w, height ?? 50.h),
        ),
      ),
      child: title,
    );
  }
}
