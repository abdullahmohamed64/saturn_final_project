import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/features/auth/models/user_model.dart';

import 'userListview_photos_item.dart';

class ListOfAllUsers extends StatelessWidget {
  const ListOfAllUsers({super.key, required this.users});
  final List<UserModel> users;
  @override

  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => horizontalSpace(20),
        itemCount: users.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              // ChatTileModel chatTileModel = ChatTileModel(
              //   receiverId: users[i].id.toString(),
              //   username: users[i].username!,
              //   lastMessage: 'lastMessage',
              //   lastMessageTime: 'lastMessageTime',
              // );
              context.pushNamed(Routes.chatRoomPage, args: users[i]);
              // ChatService().getAllLastMessages('22');
            },
            child: UserListviewPhotosItem(userModel: users[i]),
          );
        },
      ),
    );
  }
}
