import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/presentation/widgets/custom_category_grid_view_item.dart';

class CustomCategoryItemsGridView extends StatelessWidget {
  const CustomCategoryItemsGridView({super.key, required this.arts});
  final List<ArtModel> arts;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: arts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 20.h,
        ),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(Routes.artViewPage, args: arts[i]);
            },
            child: CustomCategoryGridviewItem(artModel: arts[i]),
          );
        },
      ),
    );
  }
}
