import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';
import 'package:intl/intl.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    super.key,
    required this.isReceiver,
    required this.messageModel,
  });

  final bool isReceiver;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment:
          isReceiver ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        // Display time or day-date
        Text(
          messageModel.dateTime,
          style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 12.sp),
        ),

        Align(
          alignment: isReceiver ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            constraints: BoxConstraints(maxWidth: screenWidth * 2 / 3),
            decoration: BoxDecoration(
              color:
                  isReceiver
                      ? AppColors.senderMessageColor
                      : AppColors.reiceverMessageColor,
              borderRadius: BorderRadius.only(
                topLeft: isReceiver ? Radius.zero : const Radius.circular(16).r,
                bottomRight:
                    isReceiver ? const Radius.circular(16).r : Radius.zero,
                bottomLeft: const Radius.circular(16).r,
                topRight: const Radius.circular(16).r,
              ),
            ),
            child: Text(
              messageModel.message,
              style: AppTextstyles.font16WhiteMeduim.copyWith(fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }

  String formatMessageDate(int timestamp) {
    final DateTime messageDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true).toLocal();
    final DateTime now = DateTime.now();

    final bool isToday =
        now.year == messageDate.year &&
        now.month == messageDate.month &&
        now.day == messageDate.day;

    if (isToday) {
      return DateFormat('hh:mm a').format(messageDate);
    } else {
      return '${DateFormat('EEE').format(messageDate)} - ${DateFormat('dd/MM/yyyy').format(messageDate)}';
    }
  }
}
