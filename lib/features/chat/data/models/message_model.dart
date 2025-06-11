import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/core/theming/app_constants.dart';

class MessageModel {
  final String id;
  final String chatId;
  final String message;
  final String type;
  final int senderId;
  final String dateTime;
  
  MessageModel({
    required this.id,
    required this.chatId,
    required this.message,
    required this.type,
    required this.senderId,
    required this.dateTime,
  });

  factory MessageModel.fromMap(
    Map<dynamic, dynamic> map,
    String messageId,
    String chatId,
  ) {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
      map[AppConstants.timeStamp],
    );
   String formatedDate =  AppFunctions.formatDate(date);
    return MessageModel(
      id: messageId,
      chatId: chatId,
      message: map[AppConstants.message] ?? '',
      type: map[AppConstants.type] ?? 'text',
      senderId: map[AppConstants.senderId] ?? 0,
      dateTime: formatedDate,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     AppConstants.message: message,
  //     AppConstants.type: type,
  //     AppConstants.senderId: senderId,
  //     AppConstants.timeStamp: timestamp,
  //   };
  // }
}
