import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class CustomStaggeredGridViewItem extends StatelessWidget {
  const CustomStaggeredGridViewItem({super.key, required this.artModel});
  final PostModel artModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.sp),
      child:
          artModel.imageName == null
              ? Image.asset(fit: BoxFit.cover, Assets.assetsImagesArts)
              : Image.network(
                fit: BoxFit.cover,

                ApiConstants.uploadUrl.toString() + artModel.imageName!,
              ),
    );
  }
}
