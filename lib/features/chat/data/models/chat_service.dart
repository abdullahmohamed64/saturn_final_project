// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:saturn/core/helper/extension.dart';
// import 'package:saturn/core/theming/app_constants.dart';
// import 'package:saturn/features/auth/models/user_model.dart';
// import 'package:saturn/features/chat/data/models/chat_model.dart';
// import 'package:saturn/features/chat/data/models/message_model.dart';
// import 'package:saturn/features/home/logic/cubit/home_cubit.dart';

// class ChatService {
//   final _messagesRef = FirebaseDatabase.instance.ref().child(
//     AppConstants.messages,
//   );
//   // create or get chat and return chat id
//   Future<String> createOrGetChat({
//     required String userId1,
//     required String userId2,
//   }) async {
//     try {
//       // print('Starting createOrGetChat for users: $userId1 and $userId2');
//       DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
//         AppConstants.chats,
//       );

//       DataSnapshot chatSnapShot = await chatsRef.get();
//       // print('Retrieved ${chatSnapShot.children.length} chats');

//       // Check if chat exists
//       for (var chat in chatSnapShot.children) {
//         Map<dynamic, dynamic> chatData = chat.value as Map<dynamic, dynamic>;

//         if (chatData.containsKey(AppConstants.isGroup) &&
//             chatData[AppConstants.isGroup] == false) {
//           List<String> members = [];
//           for (var member in chatData[AppConstants.members]) {
//             members.add(member);
//           }

//           if (members.contains(userId1) && members.contains(userId2)) {
//             return chat.key!;
//           }
//         } else {
//           // print('Chat has no valid members field');
//         }
//       }

//       // Create new chat
//       // print('No matching chat found, creating new chat');
//       DatabaseReference newChat = chatsRef.push();
//       await newChat.set({
//         AppConstants.isGroup: false,
//         AppConstants.members: [userId1, userId2],
//         AppConstants.createdAt: ServerValue.timestamp,
//       });
//       // print('New chat created with key: ${newChat.key}');
//       return newChat.key!;
//     } catch (e) {
//       // print('Error in createOrGetChat: ${e.toString()}');
//       rethrow;
//     }
//   }

//   Future<void> sendMessage({
//     required String chatId,
//     required int senderId,
//     required String text,
//   }) async {
//     DatabaseReference chatRef = FirebaseDatabase.instance
//         .ref()
//         .child(AppConstants.messages)
//         .child(chatId);
//     DatabaseReference newMessage = chatRef.push();
//     await newMessage.set({
//       AppConstants.message: text,
//       AppConstants.type: "text",
//       AppConstants.timeStamp: ServerValue.timestamp,
//       AppConstants.senderId: senderId,
//     });
//   }

//   Stream<DatabaseEvent> getChatMessages({required String chatId}) {
//     return FirebaseDatabase.instance
//         .ref()
//         .child(AppConstants.messages)
//         .child(chatId)
//         .orderByChild(AppConstants.timeStamp)
//         .onValue;
//   }

//   Future<List<ChatModel>> getMyChats(String userId) async {
//     DatabaseReference chatRef = FirebaseDatabase.instance.ref().child(
//       AppConstants.chats,
//     );
//     //take refrence from chatDatabase
//     DataSnapshot chatSnapShot = await chatRef.get();

//     List<ChatModel> chats = []; //all chats in databse
//     List<ChatModel> userChats = []; // chats of current user

//     for (var chat in chatSnapShot.children) {
//       Map<dynamic, dynamic> chatValue = chat.value as Map;
//       chats.add(ChatModel.fromMap(chatValue, chat.key!));
//     }

//     for (var chat in chats) {
//       if (chat.isGroup == false && !chat.members.isNullOrEmpty()) {
//         if (chat.members.contains(userId)) {
//           userChats.add(chat);
//           // print(
//           //   "********************\n${chat.members.first} ${chat.members.last}  ${chat.id}",
//           // );
//         }
//       }
//     }

//     return userChats;
//   }

//   // ids of users you make chat with them
//   Future<Map<String, MessageModel>> getChatedUsers(String userId1) async {
//     List<ChatModel> chats = await getMyChats(userId1);
//     List<String> usersId = [];

//     List<MessageModel?> lastMessages = [];
//     for (var chat in chats) {
//       if (chat.members.length != 2) continue;
//       MessageModel? lastMessage = await getLastMessage(chat.id);
//       String userId2 =
//           chat.members.first == userId1
//               ? chat.members.last
//               : chat.members.first;
//       if (lastMessage != null) {
//         usersId.add(userId2);
//         lastMessages.add(lastMessage);
//       }
//     }
//     Map<String, MessageModel> usersLastMessages = {
//       for (int i = 0; i < usersId.length; i++) usersId[i]: lastMessages[i]!,
//     };
//     return usersLastMessages;
//   }

//   // ids of chats of  users you chat with them
//   Future<List<String>> getMyChastIds(String userId) async {
//     List<String> chatsIds = [];

//     List<ChatModel> chats = await getMyChats(userId); // all chats
//     for (var chat in chats) {
//       chatsIds.add(chat.id);
//     }
//     return chatsIds;
//   }

//   // last messages of your chats
//   Future<List<MessageModel>> getAllLastMessages(String userId) async {
//     List<String> chatsId = await getMyChastIds(userId);

//     List<MessageModel> lastMessages = [];

//     for (var chatId in chatsId) {
//       MessageModel? message = await getLastMessage(chatId);
//       if (message != null) {
//         lastMessages.add(message);
//       }
//       // print("***************${lastMessages.last.dateTime}\n");
//     }

//     return lastMessages;
//   }

//   Future<MessageModel?> getLastMessage(String chatId) async {
//     DataSnapshot snapshot =
//         await _messagesRef.child(chatId).limitToLast(1).get();
//     if (snapshot.exists) {
//       final message = snapshot.children.first;
//       return MessageModel.fromMap(message.value as Map, message.key!, chatId);
//     }
//     return null;
//   }

//   Future<String> createGroupChat({
//     required List<String> members,
//     required String groupName,
//   }) async {
//     DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
//       AppConstants.chats,
//     );

//     DatabaseReference newGroupChat = chatsRef.push();
//     await newGroupChat.set({
//       AppConstants.isGroup: true,
//       AppConstants.members: [for (var member in members) member],
//       AppConstants.createdAt: ServerValue.timestamp,
//       AppConstants.groupName: groupName,
//     });

//     return newGroupChat.key!;
//   }

//   //   void saveFCMToken(String userId) async {
//   //   final fcmToken = await FirebaseMessaging.instance.getToken();
//   //   if (fcmToken != null) {
//   //     await FirebaseDatabase.instance
//   //         .ref()
//   //         .child("userTokens")
//   //         .child(userId)
//   //         .set({"token": fcmToken});
//   //   }
//   // }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/networking/api%20consumer/dio_consumer.dart';
import 'package:saturn/core/networking/api_service.dart';
import 'package:saturn/core/networking/dio_factory.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/features/chat/data/models/chat_model.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';

class ChatService {
  final _messagesRef = FirebaseDatabase.instance.ref().child(
    AppConstants.messages,
  );
  final _userTokensRef = FirebaseDatabase.instance.ref().child(
    AppConstants.userTokens,
  );

  // Your server key from Firebase Console
  // static const String _serverKey = 'AIzaSyAMXNr4RCV1T5hd3Xlbq-BFTqkUeh1h-a8';

  // // Save FCM token for user
  // // Add better error handling and debugging to your ChatService

  // // Enhanced saveFCMToken with debugging
  // Future<void> saveFCMToken(String userId) async {
  //   try {
  //     log('🔄 Attempting to save FCM token for user: $userId');

  //     final fcmToken = await FirebaseMessaging.instance.getToken();
  //     log('📱 Retrieved FCM token: ${fcmToken?.substring(0, 20)}...');

  //     if (fcmToken != null) {
  //       await _userTokensRef.child(userId).set({
  //         AppConstants.fcmToken: fcmToken,
  //         AppConstants.updatedAt: ServerValue.timestamp,
  //       });
  //       log('✅ FCM token saved successfully for user: $userId');

  //       // Verify the token was saved
  //       DataSnapshot verification = await _userTokensRef.child(userId).get();
  //       if (verification.exists) {
  //         log('✅ Token verification successful');
  //       } else {
  //         log('❌ Token verification failed');
  //       }
  //     } else {
  //       log('❌ FCM token is null');
  //     }
  //   } catch (e) {
  //     log('❌ Error saving FCM token: $e');
  //   }
  // }

  // Enhanced getFCMToken with debugging
  Future<String?> getFCMToken(String userId) async {
    try {
      print('🔍 Looking for FCM token for user: $userId');

      DataSnapshot snapshot = await _userTokensRef.child(userId).get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        String? token = data['token'] as String?;
        print(
          '✅ Found FCM token for user $userId: ${token?.substring(0, 20)}...',
        );
        return token;
      } else {
        print('❌ No FCM token found for user: $userId');

        // Debug: List all users with tokens
        DataSnapshot allTokens = await _userTokensRef.get();
        if (allTokens.exists) {
          print('📋 Available users with tokens:');
          for (var child in allTokens.children) {
            print('   - User: ${child.key}');
          }
        } else {
          print('📋 No users have tokens saved yet');
        }

        return null;
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
      return null;
    }
  }

  // Enhanced sendPushNotification with better debugging
  Future<void> sendPushNotification({
    required String targetUserId,
    required String senderName,
    required String messageText,
    required String chatId,
  }) async {
    try {
      String? fcmToken = await getFCMToken(targetUserId);
      if (fcmToken == null) {
        print('⚠️ No FCM token found for user: $targetUserId');
        return;
      }
      final Dio dio = DioFactory.getDio();
      final DioConsumer api = DioConsumer(dio: dio);
      ApiService apiService = ApiService(api: api);
      apiService.sendApiNotifiacation(
        fcmToken,
        senderName,
        messageText,
        targetUserId,
        chatId,
      );
    } catch (e) {}
  }

  // Send push notification

  // Get user name by ID (you'll need to implement this based on your user structure)
  Future<String> getUserName(int userId) async {
    try {
      // Assuming you have a users reference in your database
      DataSnapshot snapshot =
          await FirebaseDatabase.instance
              .ref()
              .child('users')
              .child(userId.toString())
              .get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> userData =
            snapshot.value as Map<dynamic, dynamic>;
        return userData['name'] ?? 'Unknown User';
      }
      return 'Unknown User';
    } catch (e) {
      print('Error getting user name: $e');
      return 'Unknown User';
    }
  }

  // Enhanced sendMessage with notification
  Future<void> sendMessage({
    required String chatId,
    required int senderId,
    required String text,
    String? senderName,
  }) async {
    try {
      // Send the message to database
      DatabaseReference chatRef = FirebaseDatabase.instance
          .ref()
          .child(AppConstants.messages)
          .child(chatId);
      DatabaseReference newMessage = chatRef.push();

      await newMessage.set({
        AppConstants.message: text,
        AppConstants.type: "text",
        AppConstants.timeStamp: ServerValue.timestamp,
        AppConstants.senderId: senderId,
      });

      // Get chat members to send notifications
      List<String> chatMembers = await getChatMembers(chatId);
      String displaySenderName = senderName ?? await getUserName(senderId);

      // Send notifications to all members except sender
      // for (String memberId in chatMembers) {
      //   if (memberId != senderId.toString()) {
      //     await sendPushNotification(
      //       targetUserId: memberId,
      //       senderName: displaySenderName,
      //       messageText: text,
      //       chatId: chatId,
      //     );
      //   }
      // }
    } catch (e) {
      print('Error in sendMessage: $e');
      rethrow;
    }
  }

  // Get chat members
  Future<List<String>> getChatMembers(String chatId) async {
    try {
      DataSnapshot snapshot =
          await FirebaseDatabase.instance
              .ref()
              .child(AppConstants.chats)
              .child(chatId)
              .get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> chatData =
            snapshot.value as Map<dynamic, dynamic>;
        List<String> members = [];
        if (chatData.containsKey(AppConstants.members)) {
          for (var member in chatData[AppConstants.members]) {
            members.add(member.toString());
          }
        }
        return members;
      }
      return [];
    } catch (e) {
      print('Error getting chat members: $e');
      return [];
    }
  }

  // create or get chat and return chat id
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    try {
      DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
        AppConstants.chats,
      );

      DataSnapshot chatSnapShot = await chatsRef.get();

      // Check if chat exists
      for (var chat in chatSnapShot.children) {
        Map<dynamic, dynamic> chatData = chat.value as Map<dynamic, dynamic>;

        if (chatData.containsKey(AppConstants.isGroup) &&
            chatData[AppConstants.isGroup] == false) {
          List<String> members = [];
          for (var member in chatData[AppConstants.members]) {
            members.add(member);
          }

          if (members.contains(userId1) && members.contains(userId2)) {
            return chat.key!;
          }
        }
      }

      // Create new chat
      DatabaseReference newChat = chatsRef.push();
      await newChat.set({
        AppConstants.isGroup: false,
        AppConstants.members: [userId1, userId2],
        AppConstants.createdAt: ServerValue.timestamp,
      });
      return newChat.key!;
    } catch (e) {
      rethrow;
    }
  }

  Stream<DatabaseEvent> getChatMessages({required String chatId}) {
    return FirebaseDatabase.instance
        .ref()
        .child(AppConstants.messages)
        .child(chatId)
        .orderByChild(AppConstants.timeStamp)
        .onValue;
  }

  Future<List<ChatModel>> getMyChats(String userId) async {
    DatabaseReference chatRef = FirebaseDatabase.instance.ref().child(
      AppConstants.chats,
    );
    DataSnapshot chatSnapShot = await chatRef.get();

    List<ChatModel> chats = [];
    List<ChatModel> userChats = [];

    for (var chat in chatSnapShot.children) {
      Map<dynamic, dynamic> chatValue = chat.value as Map;
      chats.add(ChatModel.fromMap(chatValue, chat.key!));
    }

    for (var chat in chats) {
      if (chat.isGroup == false && !chat.members.isNullOrEmpty()) {
        if (chat.members.contains(userId)) {
          userChats.add(chat);
        }
      }
    }

    return userChats;
  }

  Future<Map<String, MessageModel>> getChatedUsers(String userId1) async {
    List<ChatModel> chats = await getMyChats(userId1);
    List<String> usersId = [];
    List<MessageModel?> lastMessages = [];

    for (var chat in chats) {
      if (chat.members.length != 2) continue;
      MessageModel? lastMessage = await getLastMessage(chat.id);
      String userId2 =
          chat.members.first == userId1
              ? chat.members.last
              : chat.members.first;
      if (lastMessage != null) {
        usersId.add(userId2);
        lastMessages.add(lastMessage);
      }
    }

    Map<String, MessageModel> usersLastMessages = {
      for (int i = 0; i < usersId.length; i++) usersId[i]: lastMessages[i]!,
    };
    return usersLastMessages;
  }

  Future<List<String>> getMyChastIds(String userId) async {
    List<String> chatsIds = [];
    List<ChatModel> chats = await getMyChats(userId);

    for (var chat in chats) {
      chatsIds.add(chat.id);
    }
    return chatsIds;
  }

  Future<List<MessageModel>> getAllLastMessages(String userId) async {
    List<String> chatsId = await getMyChastIds(userId);
    List<MessageModel> lastMessages = [];

    for (var chatId in chatsId) {
      MessageModel? message = await getLastMessage(chatId);
      if (message != null) {
        lastMessages.add(message);
      }
    }

    return lastMessages;
  }

  Future<MessageModel?> getLastMessage(String chatId) async {
    DataSnapshot snapshot =
        await _messagesRef.child(chatId).limitToLast(1).get();
    if (snapshot.exists) {
      final message = snapshot.children.first;
      return MessageModel.fromMap(message.value as Map, message.key!, chatId);
    }
    return null;
  }

  Future<String> createGroupChat({
    required List<String> members,
    required String groupName,
  }) async {
    DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
      AppConstants.chats,
    );

    DatabaseReference newGroupChat = chatsRef.push();
    await newGroupChat.set({
      AppConstants.isGroup: true,
      AppConstants.members: [for (var member in members) member],
      AppConstants.createdAt: ServerValue.timestamp,
      AppConstants.groupName: groupName,
    });

    return newGroupChat.key!;
  }
}
