import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_text_filed.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

class SendMessageTextField extends StatefulWidget {
  const SendMessageTextField({
    super.key,
    required this.chatId,
    required this.senderId,
  });
  final String chatId;
  final int senderId;

  @override
  State<SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<SendMessageTextField> {
  late TextEditingController messageController;
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,

      child: CustomTextField(
        controller: messageController,
        textFieldStyle: AppTextstyles.font16WhiteMeduim,
        hintTextStyle: AppTextstyles.font12WhiteRegular,
        enabledBorderColor: AppColors.senderMessageColor,
        focusdBorderColor: AppColors.senderMessageColor,
        backgroundColor: AppColors.senderMessageColor,
        hintText: 'Message',
        suffixIcon: IconButton(
          onPressed: () {
            ChatService().sendMessage(
              chatId: widget.chatId,
              senderId: widget.senderId,
              text: messageController.text,
            );

            context.read<HomeCubit>().getListOfUsersById(
              widget.senderId.toString(),
            );

            messageController.clear();
          },
          icon: Icon(Icons.send, color: AppColors.white),
        ),
      ),
    );
  }
}
