import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';

import 'userListview_photos_item.dart';

class UsersListviewPhotos extends StatelessWidget {
  const UsersListviewPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
          height: 110.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => horizontalSpace(20),
            itemCount: 10,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                 ChatService().getAllLastMessages();
                },
                child: UserListviewPhotosItem(),
              );
            },
          ),
        );
  }
}
