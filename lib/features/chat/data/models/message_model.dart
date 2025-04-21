import 'package:saturn/core/theming/app_constants.dart';

class Message {
  final String id;
  final String chatId;
  final String message;
  final String type;
  final int senderId;
  final int timestamp;
  
  Message({
    required this.id,
    required this.chatId,
    required this.message,
    required this.type,
    required this.senderId,
    required this.timestamp,
  });
  
  factory Message.fromMap(Map<dynamic, dynamic> map, String messageId, String chatId) {
    return Message(
      id: messageId,
      chatId: chatId,
      message: map[AppConstants.message] ?? '',
      type: map[AppConstants.type] ?? 'text',
      senderId: map[AppConstants.senderId] ?? 0,
      timestamp: map[AppConstants.timeStamp] ?? 0,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      AppConstants.message: message,
      AppConstants.type: type,
      AppConstants.senderId: senderId,
      AppConstants.timeStamp: timestamp,
    };
  }
}
