import 'package:firebase_database/firebase_database.dart';
import 'package:saturn/core/theming/app_constants.dart';

class ChatService {
  DatabaseReference firebaseDatabaseRef = FirebaseDatabase.instance.ref();
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    DatabaseReference chatsRef = firebaseDatabaseRef.child(AppConstants.chats);

    DataSnapshot snapShot = await chatsRef.get();
    // get chat
    for (var chat in snapShot.children) {
      //loop on chats
      Map<dynamic, dynamic> chatData = chat.value as Map;
      if (chatData[AppConstants.isGroup] == false) {
        List<String> members =
            chatData[AppConstants.members].keys.toList();
        if (members.contains(userId1) && members.contains(userId2)) {
          return chat.key!;
        }
      }
    }

    // create chat
    DatabaseReference newChat = chatsRef.push();
    newChat.set({
      AppConstants.isGroup: false,
      AppConstants.members: {userId1: true, userId2: true},
      AppConstants.createdAt: ServerValue.timestamp,
    });
    return newChat.key!;
  }

  void sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) {
    DatabaseReference chatRef = firebaseDatabaseRef
        .child(AppConstants.messages)
        .child(chatId);
    DatabaseReference newMessage = chatRef.push();
    newMessage.set({
      AppConstants.message: text,
      AppConstants.type: "text",
      AppConstants.timeStamp: ServerValue.timestamp,
      AppConstants.senderId: senderId,
    });
  }

  Stream<DatabaseEvent> getMessagesOnChat({required String chatId}) {
    return firebaseDatabaseRef
        .child(AppConstants.messages)
        .child(chatId)
        .orderByChild(AppConstants.timeStamp)
        .onValue;
  }

  void createGroupChat({
    required List<String> members,
    required String groupName,
  }) {
    DatabaseReference chatsRef = firebaseDatabaseRef.child(AppConstants.chats);

    DatabaseReference newGroupChat = chatsRef.push();
    newGroupChat.set({
      AppConstants.isGroup: true,
      AppConstants.members: {for (var member in members) member: true},
      AppConstants.createdAt: ServerValue.timestamp,
      AppConstants.groupName: groupName,
    });
  }
}
