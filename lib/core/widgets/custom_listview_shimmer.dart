import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/widgets/custom_shimmer_item.dart';

class CustomListViewShimmer extends StatelessWidget {
  const CustomListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.h,
      child: ListView.separated(
        separatorBuilder: (context, i)=>verticalSpace(20),
        itemCount: 6,
        itemBuilder: (context, i){
        return ShimmerItem();
      }),
    );
  }
}