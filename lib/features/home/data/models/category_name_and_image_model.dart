import 'package:flutter/widgets.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/theming/app_colors.dart';

class CategoryNameAndImageModel {
  final String categoryName;
  final String categoryImage;
  final Color categoryColor;

  CategoryNameAndImageModel({
    required this.categoryName,
    required this.categoryImage,
    required this.categoryColor,
  });
}

List<CategoryNameAndImageModel> categories = [
  /*
 Logos
Home design 
Animation 
Pic
Handmade
Painting
 */
  CategoryNameAndImageModel(
    categoryName: 'Painting',
    categoryImage: Assets.assetsImagesPainting,
    categoryColor: AppColors.paintingCategoryColor,
  ),
  CategoryNameAndImageModel(
    categoryName: 'Logos',
    categoryImage: Assets.assetsImagesLogo,
    categoryColor: AppColors.logosCategoryColor,
  ),
  CategoryNameAndImageModel(
    categoryName: 'HandMade',
    categoryImage: Assets.assetsImagesHandMade,
    categoryColor: AppColors.handMadeCategoryColor,
  ),
  CategoryNameAndImageModel(
    categoryName: 'Pic',
    categoryImage: Assets.assetsImagesPic,
    categoryColor: const Color.fromARGB(255, 43, 164, 117),
  ),
  CategoryNameAndImageModel(
    categoryName: 'Home design',
    categoryImage: Assets.assetsImagesDesign,
    categoryColor: AppColors.homeDesignCategoryColor,
  ),
  CategoryNameAndImageModel(
    categoryName: 'Animation',
    categoryImage: Assets.assetsImagesOnBoardingImage,
    categoryColor: AppColors.animationCategoryColor,
  ),
];
