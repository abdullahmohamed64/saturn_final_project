
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/data/models/art_model.dart';
import '../../../home/presentation/widgets/custom_home_arts_grid_view.dart';
class GridViewContainer extends StatelessWidget {
  const GridViewContainer({super.key, required this.mdQry, required this.arts});

  final Size mdQry;
  final List<ArtModel> arts;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      height: mdQry.height * 3 / 6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(64.r)),
      child: CustomHomeArtsGridView(artModels: arts),
    );
  }
}