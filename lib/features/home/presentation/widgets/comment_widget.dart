import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/theming/fontweight_helpr.dart';

class CommentWidget extends StatelessWidget {
  final String comment;
  final String userName;
  final String createdAt;
  final String? userAvatar;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.userName,
    required this.createdAt,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    // Format the creation date
    final DateTime parsedDate = DateTime.parse(createdAt);
    final String formattedDate = DateFormat(
      'MMM d, yyyy • h:mm',
    ).format(parsedDate);

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xff48484840),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black,
          //   blurRadius: 4,
          //   offset: const Offset(0, 2),
          // ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info row
          Row(
            children: [
              // User avatar
              CircleAvatar(
                radius: 28.r,
                // backgroundColor: AppColors.black,
                backgroundImage:
                    userAvatar != null
                        ? NetworkImage(ApiConstants.uploadUrl + userAvatar!)
                        : null,
                child:
                    userAvatar == null
                        ? Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : null,
              ),
              horizontalSpace(10),
              // User name and date
              SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName[0].toUpperCase() + userName.substring(1),
                      style: AppTextstyles.font16WhiteMeduim.copyWith(
                        color: Colors.white,
                        fontWeight: AppFontWeightHelper.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Text(formattedDate, style: AppTextstyles.font12GreyRegular),
                  ],
                ),
              ),
            ],
          ),

          // Comment text
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 42.w),
            child: Text(
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              comment,
              style: AppTextstyles.font12WhiteRegular.copyWith(
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
