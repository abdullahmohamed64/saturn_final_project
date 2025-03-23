import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class DeepBuleContainer extends StatelessWidget {
  const DeepBuleContainer({super.key, required this.mdQry});

  final Size mdQry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mdQry.height * 5 / 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),

        color: AppColors.deepPurple,
      ),
    );
  }
}
