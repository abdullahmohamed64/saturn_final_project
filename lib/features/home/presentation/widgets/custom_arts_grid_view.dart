import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:saturn/features/home/presentation/widgets/custom_arts_gridview_item.dart';

class CustomArtsGridView extends StatelessWidget {
  const CustomArtsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: GridView.builder(
        // shrinkWrap: true,
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.w,
          mainAxisSpacing: 5.h,
          childAspectRatio: 4 / 5,
          // ,
          // childAspectRatio: 1/1,
        ),
        itemBuilder: (context, i) {
          return CustomArtsGridViewItem();
        },
      ),
    );
  }
}
