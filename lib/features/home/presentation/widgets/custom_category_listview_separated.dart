import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';

import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/home/data/models/category_name_and_image_model.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/home/presentation/widgets/custom_listview_separated_item.dart';

class CustomCategoryListviewSeparated extends StatelessWidget {
  const CustomCategoryListviewSeparated({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, i) => horizontalSpace(10),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              context.read<HomeCubit>().getCategoyItems(
                categoryName: categories[i].categoryName,
              );
            
              context.pushNamed(Routes.categoryPage ,args: categories[i].categoryName);
            },
            child: CustomCategoryListviewSparatedItem(
              categoryNameAndImageModel: categories[i],
            ),
          );
        },
      ),
    );
  }
}
