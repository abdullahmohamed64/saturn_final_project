import 'package:firebase_database/firebase_database.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/theming/app_constants.dart';
import 'package:saturn/features/chat/data/models/chat_model.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';

class ChatService {
  // create or get chat and return chat id
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    try {
      // print('Starting createOrGetChat for users: $userId1 and $userId2');
      DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
        AppConstants.chats,
      );

      DataSnapshot chatSnapShot = await chatsRef.get();
      // print('Retrieved ${chatSnapShot.children.length} chats');

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
        } else {
          // print('Chat has no valid members field');
        }
      }

      // Create new chat
      // print('No matching chat found, creating new chat');
      DatabaseReference newChat = chatsRef.push();
      await newChat.set({
        AppConstants.isGroup: false,
        AppConstants.members: [userId1, userId2],
        AppConstants.createdAt: ServerValue.timestamp,
      });
      // print('New chat created with key: ${newChat.key}');
      return newChat.key!;
    } catch (e) {
      // print('Error in createOrGetChat: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required int senderId,
    required String text,
  }) async {
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
    //take refrence from chatDatabase
    DataSnapshot chatSnapShot = await chatRef.get();

    List<ChatModel> chats = []; //all chats in databse
    List<ChatModel> userChats = []; // chats of current user

    for (var chat in chatSnapShot.children) {
      Map<dynamic, dynamic> chatValue = chat.value as Map;
      chats.add(ChatModel.fromMap(chatValue, chat.key!));
    }

    for (var chat in chats) {
      if (chat.isGroup == false && !chat.members.isNullOrEmpty()) {
        if (chat.members.contains(userId)) {
          userChats.add(chat);
          // print(
          //   "********************\n${chat.members.first} ${chat.members.last}  ${chat.id}",
          // );
        }
      }
    }

    return userChats;
  }
// ids of users you make chat with them
  Future<List<String>> getChatedUsersId(String userId) async {
    List<ChatModel> chats = await getMyChats(userId);
    List<String> usersId = [];
    for (var chat in chats) {
      usersId.add(chat.members.last);
    }
    return usersId;
  }
// ids of chats of  users you chat with them 
  Future<List<String>> getChatedUsersChatId(String userId) async {
    List<String> chatsIds = [];

   List <ChatModel> chats = await getMyChats(userId);
     for (var chat in chats) {
       chatsIds.add(chat.id);
     }
    return chatsIds;
  }
 // last messages of your chats 
  Future<List<MessageModel>> getAllLastMessages(String userId) async {
    List<String> chatsId = await getChatedUsersChatId(userId);
    final messagesRef = FirebaseDatabase.instance.ref().child(
      AppConstants.messages,
    );

    List<MessageModel> lastMessages = [];
  
  
    for (var chatId in chatsId) {
      DataSnapshot snapshot =
          await messagesRef.child(chatId).limitToLast(1).get();
      if (snapshot.exists) {
      final message =   snapshot.children.first;
        lastMessages.add(MessageModel.fromMap(message.value as Map, message.key!, chatId));
        // print("***************${lastMessages.last.dateTime}\n");
      }
    }
  
    return lastMessages;
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
