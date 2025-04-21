
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/features/profile/presentaion/widgets/custom_profile_gridview.dart';
import 'package:saturn/features/profile/presentaion/widgets/staggered_gridview_item.dart';

import '../../../home/data/models/art_model.dart';
import '../../../home/presentation/widgets/custom_home_arts_grid_view.dart';
class StaggeredGridViewContainer extends StatelessWidget {
  const StaggeredGridViewContainer({super.key, required this.mdQry, required this.arts});

  final Size mdQry;
  final List<ArtModel> arts;
  @override
  Widget build(BuildContext context) {
    return Container(
    
      padding: EdgeInsets.all(16.r),
      height: mdQry.height * 3 / 6,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(64.r)),
      child:      CustomProfileStaggeredGridview(artModels: arts),
    );
  }
}