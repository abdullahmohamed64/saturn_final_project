
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/widgets/dashed_line.dart';

class CustomWhiteContainer extends StatelessWidget {
  const CustomWhiteContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          verticalSpace(15),
          DashedLine(),
   
        ],
      ),
    );
  }
}

