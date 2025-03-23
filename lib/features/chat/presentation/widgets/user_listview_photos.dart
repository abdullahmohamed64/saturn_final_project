import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';

import 'userListview_photos_item.dart';

class UserListviewPhotos extends StatelessWidget {
  const UserListviewPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => horizontalSpace(20),
        itemCount: 10,
        itemBuilder: (context, i) {
          return UserListviewPhotosItem();
        },
      ),
    );
  }
}
