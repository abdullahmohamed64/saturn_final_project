import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/widgets/custom_shimmer_item.dart';

class CustomGridViewShimmer extends StatelessWidget {
  const CustomGridViewShimmer({super.key, this.length});
  final int? length;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 20.h,
            crossAxisSpacing: 20.w,
          ),
          itemCount: length ?? 6,
          itemBuilder: (cotext, i) {
            return ShimmerItem();
          },
        ),
      ),
    );
  }
}
