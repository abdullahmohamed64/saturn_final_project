import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

import 'package:saturn/features/home/presentation/widgets/custom_arts_gridview_item.dart';

class CustomHomeArtsGridView extends StatelessWidget {
  const CustomHomeArtsGridView({super.key, required this.postModels});
  final List<PostModel> postModels;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: GridView.builder(
        // shrinkWrap: true,
        itemCount: postModels.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.w,
          // mainAxisSpacing: 5.h,
          childAspectRatio: 5 / 6,
          // ,
          // childAspectRatio: 1/1,
        ),
        itemBuilder: (context, i) {
          return CustomArtsGridViewItem(artModel: postModels[i]);
        },
      ),
    );
  }
}
