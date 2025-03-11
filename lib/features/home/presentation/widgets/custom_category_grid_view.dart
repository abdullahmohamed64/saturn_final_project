import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view_item.dart';

class CustomCategoryItemsGridView extends StatelessWidget {
  const CustomCategoryItemsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 20.h,
        ),
        itemBuilder: (context, i) {
          return CustomCategoryGridviewItem();
        },
      ),
    );
  }
}