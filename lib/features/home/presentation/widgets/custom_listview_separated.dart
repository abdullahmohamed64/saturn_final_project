import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';

class CustomListviewSeparated extends StatelessWidget {
  const CustomListviewSeparated({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        separatorBuilder: (context, i) => horizontalSpace(20),
        itemBuilder: (context, i) {
          return Column(
            children: [
              Image.asset(Assets.assetsImagesPainting, height: 50),
              Text('painting'),
            ],
          );
        },
      ),
    );
  }
}
