import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    super.key,
    required this.isSender,
    required this.messageData,
  });

  final bool isSender;
  final Map<dynamic, dynamic> messageData;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
        constraints: BoxConstraints(maxWidth: screenWidth * 2 / 3),
        decoration: BoxDecoration(
          color:
              isSender
                  ? AppColors.senderMessageColor
                  : AppColors.reiceverMessageColor,
          borderRadius: BorderRadius.only(
            topLeft: isSender ? Radius.zero : const Radius.circular(16).r,
            bottomRight: isSender ? const Radius.circular(16).r : Radius.zero,

            bottomLeft: const Radius.circular(16).r,
            topRight: const Radius.circular(16).r,
          ),
        ),
        child: Text(
          messageData[AppConstants.message],
          style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }
}
