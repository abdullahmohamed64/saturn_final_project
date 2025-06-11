import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

import 'package:saturn/features/profile/presentaion/widgets/staggered_gridview_item.dart';
import 'package:staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomProfileStaggeredGridview extends StatelessWidget {
  const CustomProfileStaggeredGridview({super.key, required this.artModels});
  final List<ArtModel> artModels;
  @override
  Widget build(BuildContext context) {
    int c = 1;
    return SizedBox(
      height: 500.h,
      child: StaggeredGridView.countBuilder(
        itemCount: artModels.length,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.h,
        crossAxisCount: 2,
        itemBuilder: (context, i) {
          c + 5;

          return CustomStaggeredGridViewItem(artModel: artModels[i]);
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, (index == c) ? 3 : 2);
        },
      ),
    );
  }
}
