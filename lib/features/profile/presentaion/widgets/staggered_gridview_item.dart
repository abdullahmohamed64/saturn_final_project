import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class CustomStaggeredGridViewItem extends StatelessWidget {
  const CustomStaggeredGridViewItem({super.key, required this.artModel});
  final ArtModel artModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.sp),
      child:
          artModel.imageName == null
              ? Image.asset(fit: BoxFit.cover, Assets.assetsImagesArts)
              : Image.network(
                fit: BoxFit.cover,
    
                ApiConstants.upload + artModel.imageName!,
              ),
    );
  }
}
