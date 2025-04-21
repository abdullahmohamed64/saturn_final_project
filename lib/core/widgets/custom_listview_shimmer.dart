import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/widgets/custom_shimmer_item.dart';

class CustomListViewShimmer extends StatelessWidget {
  const CustomListViewShimmer({super.key, this.scrollDirection, this.height});
final Axis? scrollDirection;
final double? height;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height?.h ?? 800.h,
      child: ListView.separated(
        scrollDirection: scrollDirection ?? Axis.vertical,
        separatorBuilder: (context, i)=>verticalSpace(20),
        itemCount: 6,
        itemBuilder: (context, i){
        return ShimmerItem();
      }),
    );
  }
}