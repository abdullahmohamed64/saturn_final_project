import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/networking/api_constants.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';
import 'package:saturn/features/chat/presentation/widgets/buble_message.dart';
import 'package:saturn/features/home/logic/cubit/home_cubit.dart';
import 'package:saturn/features/profile/presentaion/widgets/user_image.dart';

class ChatRoomListviewMessages extends StatelessWidget {
  const ChatRoomListviewMessages({
    super.key,
    required this.chatId,
    required this.senderId,
    required this.userName,
    this.userImage,
  });
  final String chatId;
  final String senderId;
  final String userName;
  final String? userImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(30),
        SizedBox(
          height: 100.h,
          child: Row(
            
            children: [
              horizontalSpace(10),
               CircleAvatar(
          radius: 22.sp,

          child:
              userImage.isNullOrEmpty()
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(32.sp),
                    child: Image.asset(
                      Assets.assetsImagesUserAvatar,
                      fit: BoxFit.cover,
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(32.sp),
                    child: CachedNetworkImage(
                      imageUrl:
                          userImage.isNullOrEmpty()
                              ? 'https://tse4.mm.bing.net/th/id/OIP._qD62an0_iiWX0pzZRUOZwHaFj?r=0&rs=1&pid=ImgDetMain&o=7&rm=3'
                              : ApiConstants.uploadUrl.toString() +
                                  userImage!,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.sp),

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
        horizontalSpace(10),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: AppTextstyles.font16WhiteSemiBold.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: ChatService().getChatMessages(chatId: chatId),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 70.sp,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Something went wrong",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return Center(
                  child: Text(
                    "No messages yet.",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }

              Map<dynamic, dynamic> messages =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages found.",
                    style: AppTextstyles.font16WhiteMeduim,
                  ),
                );
              }
              context.read<HomeCubit>().getListOfUsersById(senderId.toString());
              List<MapEntry<dynamic, dynamic>> sortedMessages =
                  messages.entries.toList();
              sortedMessages.sort(
                (a, b) => b.value[AppConstants.timeStamp].compareTo(
                  a.value[AppConstants.timeStamp],
                ),
              );
              return ListView.builder(
                reverse: true,

                itemCount: sortedMessages.length,
                itemBuilder: (context, i) {
                  var message = sortedMessages[i].value;

                  MessageModel messageModel = MessageModel.fromMap(
                    message,
                    "",
                    "",
                  );
                  bool isReceiver = messageModel.senderId.toString() != senderId;
                  return BubbleMessage(
                    isReceiver: isReceiver,
                    messageModel: messageModel,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
