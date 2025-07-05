import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/features/profile/presentaion/widgets/custom_profile_gridview.dart';

import '../../../home/data/models/art_model.dart';

class StaggeredGridViewContainer extends StatelessWidget {
  const StaggeredGridViewContainer({
    super.key,
    required this.mdQry,
    required this.arts,
  });

  final Size mdQry;
  final List<PostModel> arts;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      height: mdQry.height * 3 / 6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(64.r)),
      child: CustomProfileStaggeredGridview(artModels: arts),
    );
  }
}
