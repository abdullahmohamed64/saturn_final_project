import 'package:firebase_database/firebase_database.dart';
import 'package:saturn/core/theming/app_constants.dart';

class ChatService {
  // create or get chat and return chat id
  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
  }) async {
    try {
      print('Starting createOrGetChat for users: $userId1 and $userId2');
      DatabaseReference chatsRef = FirebaseDatabase.instance.ref().child(
        AppConstants.chats,
      );

      DataSnapshot snapShot = await chatsRef.get();
      print('Retrieved ${snapShot.children.length} chats');

      // Check if chat exists
      for (var chat in snapShot.children) {
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
          print('Chat has no valid members field');
        }
      }

      // Create new chat
      print('No matching chat found, creating new chat');
      DatabaseReference newChat = chatsRef.push();
      await newChat.set({
        AppConstants.isGroup: false,
        AppConstants.members: [userId1, userId2],
        AppConstants.createdAt: ServerValue.timestamp,
      });
      print('New chat created with key: ${newChat.key}');
      return newChat.key!;
    } catch (e) {
      print('Error in createOrGetChat: ${e.toString()}');
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

  Stream<DatabaseEvent> getMessagesOnChat({required String chatId}) {
    return FirebaseDatabase.instance
        .ref()
        .child(AppConstants.messages)
        .child(chatId)
        .orderByChild(AppConstants.timeStamp)
        .onValue;
  }

Future<  List<String>> getAllUserschatsKey()async {
    List<String> chatsId = [];
  DataSnapshot collection = await  FirebaseDatabase.instance
        .ref()
        .child(AppConstants.chats)
        .get();

        for (var element in collection.children) {

          chatsId.add(element.key!);
        }
     
        return chatsId;
  }
  getAllLastMessages()async{
    List<String >chatsId = await getAllUserschatsKey();
    final firebaseRef = FirebaseDatabase.instance.ref().child(AppConstants.messages);

    List<Map>lastMessages = [];
    for (var chatId in chatsId) {
      DataSnapshot snapshot = await firebaseRef.child(chatId).limitToLast(1).get();
      if(snapshot.exists){
        lastMessages.add(snapshot.children.first.value as Map);
        print(snapshot.value );
      }
    }
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
