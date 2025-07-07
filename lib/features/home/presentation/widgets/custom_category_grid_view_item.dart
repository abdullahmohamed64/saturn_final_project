import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

class CustomCategoryGridviewItem extends StatelessWidget {
  const CustomCategoryGridviewItem({super.key, required this.artModel});
  final PostModel artModel;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
              clipBehavior: Clip.hardEdge,

      height: 100.h,
      width: 200.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            AppColors.black,
            const Color.fromARGB(255, 75, 72, 72),
            const Color.fromARGB(255, 59, 15, 109),
          ],
        ),
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width / 5,
            child: ClipRRect(
              
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.sp), bottomLeft: Radius.circular(16.sp)),
              child: CachedNetworkImage(
                imageUrl:
                    artModel.imageName.isNullOrEmpty()
                        ? 'https://tse4.mm.bing.net/th/id/OIP._qD62an0_iiWX0pzZRUOZwHaFj?r=0&rs=1&pid=ImgDetMain&o=7&rm=3'
                        : ApiConstants.uploadUrl + artModel.imageName!,
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // artModel.imageName == null
          //     ? Image.asset(Assets.assetsImagesBag, height: 100.h, width: 70.w)
          //     : Image.network(
          //       ApiConstants.uploadUrl.toString() + artModel.imageName!,
          //       height: 100.h,
          //       width: 70.w,
          //     ),
          SizedBox(
            width: width / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                     'Design',
                    style: AppTextstyles.font16WhitekSemiBold,
                  ),
                ),
                verticalSpace(20),
                Flexible(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    artModel.categoryName ?? '',
                    style: AppTextstyles.font16WhitekSemiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
