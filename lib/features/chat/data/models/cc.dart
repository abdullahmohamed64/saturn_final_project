// import 'package:firebase_database/firebase_database.dart';
// import 'package:saturn/core/theming/app_constants.dart';
// import 'package:saturn/features/chat/data/models/chat_model.dart';
// import 'package:saturn/features/chat/data/models/message_model.dart';

// class ChatService {
//   final DatabaseReference _chatsRef = FirebaseDatabase.instance.ref().child(
//     AppConstants.chats,
//   );
//   final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child(
//     AppConstants.messages,
//   );

//   // Create or get chat and return chat id
//   Future<String> createOrGetChat({
//     required String userId1,
//     required String userId2,
//   }) async {
//     try {
//       print('Starting createOrGetChat for users: $userId1 and $userId2');

//       DataSnapshot snapShot = await _chatsRef.get();
//       print('Retrieved ${snapShot.children.length} chats');

//       // Check if chat exists
//       for (var chat in snapShot.children) {
//         Map<dynamic, dynamic> chatData = chat.value as Map<dynamic, dynamic>;

//         if (chatData.containsKey(AppConstants.isGroup) &&
//             chatData[AppConstants.isGroup] == false) {
//           List<String> members = [];
//           if (chatData[AppConstants.members] != null) {
//             for (var member in chatData[AppConstants.members]) {
//               members.add(member.toString());
//             }

//             if (members.contains(userId1) && members.contains(userId2)) {
//               return chat.key!;
//             }
//           }
//         }
//       }

//       // Create new chat
//       print('No matching chat found, creating new chat');
//       DatabaseReference newChat = _chatsRef.push();
//       await newChat.set({
//         AppConstants.isGroup: false,
//         AppConstants.members: [userId1, userId2],
//         AppConstants.createdAt: ServerValue.timestamp,
//       });
//       print('New chat created with key: ${newChat.key}');
//       return newChat.key!;
//     } catch (e) {
//       print('Error in createOrGetChat: ${e.toString()}');
//       rethrow;
//     }
//   }

//   // Send message to a chat
//   Future<Message> sendMessage({
//     required String chatId,
//     required int senderId,
//     required String text,
//     String type = "text",
//   }) async {
//     DatabaseReference chatRef = _messagesRef.child(chatId);
//     DatabaseReference newMessage = chatRef.push();

//     final messageData = {
//       AppConstants.message: text,
//       AppConstants.type: type,
//       AppConstants.timeStamp: ServerValue.timestamp,
//       AppConstants.senderId: senderId,
//     };

//     await newMessage.set(messageData);

//     // For immediate use in UI, create a Message object with current timestamp
//     final currentTimestamp = DateTime.now().millisecondsSinceEpoch;

//     return Message(
//       id: newMessage.key!,
//       chatId: chatId,
//       message: text,
//       type: type,
//       senderId: senderId,
//       timestamp: currentTimestamp,
//     );
//   }

//   // Get stream of messages for a chat
//   Stream<List<Message>> getMessagesOnChat({required String chatId}) {
//     return _messagesRef
//         .child(chatId)
//         .orderByChild(AppConstants.timeStamp)
//         .onValue
//         .map((event) {
//           List<Message> messages = [];
//           if (event.snapshot.value != null) {
//             Map<dynamic, dynamic> messagesMap =
//                 event.snapshot.value as Map<dynamic, dynamic>;

//             messagesMap.forEach((key, value) {
//               messages.add(
//                 Message.fromMap(
//                   value as Map<dynamic, dynamic>,
//                   key.toString(),
//                   chatId,
//                 ),
//               );
//             });

//             // Sort by timestamp (newest last)
//             messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//           }
//           return messages;
//         });
//   }

//   // Get all chat IDs

//   Future<List<String>> getAllChatIds() async {
//     List<String> chatsIds = [];
//     DataSnapshot collection = await _chatsRef.get();

//     for (var element in collection.children) {
//       chatsIds.add(element.key!);
//     }

//     return chatsIds;
//   }

//   // Get all last messages
//   Future<List<Message>> getAllLastMessages() async {
//     List<String> chatsIds = await getAllChatIds();
//     List<Message> lastMessages = [];

//     for (var chatId in chatsIds) {
//       DataSnapshot snapshot =
//           await _messagesRef
//               .child(chatId)
//               .orderByChild(AppConstants.timeStamp)
//               .limitToLast(1)
//               .get();

//       if (snapshot.exists && snapshot.children.isNotEmpty) {
//         var child = snapshot.children.first;
//         var messageId = child.key ?? '';
//         var messageData = child.value as Map<dynamic, dynamic>;
//         lastMessages.add(Message.fromMap(messageData, messageId, chatId));
//       }
//     }

//     return lastMessages;
//   }

//   // Get all chats with their last messages
//   Future<Map<ChatModel, Message?>> getAllChatsWithLastMessages() async {
//     DataSnapshot chatsSnapshot = await _chatsRef.get();
//     Map<ChatModel, Message?> chatsWithMessages = {};

//     for (var chatSnapshot in chatsSnapshot.children) {
//       String chatId = chatSnapshot.key!;
//       Map<dynamic, dynamic> chatData =
//           chatSnapshot.value as Map<dynamic, dynamic>;
//       ChatModel chat = ChatModel.fromMap(chatData, chatId);

//       // Get last message
//       DataSnapshot lastMessageSnapshot =
//           await _messagesRef
//               .child(chatId)
//               .orderByChild(AppConstants.timeStamp)
//               .limitToLast(1)
//               .get();

//       Message? lastMessage;
//       if (lastMessageSnapshot.exists &&
//           lastMessageSnapshot.children.isNotEmpty) {
//         var child = lastMessageSnapshot.children.first;
//         var messageId = child.key ?? '';
//         var messageData = child.value as Map<dynamic, dynamic>;
//         lastMessage = Message.fromMap(messageData, messageId, chatId);
//       }

//       chatsWithMessages[chat] = lastMessage;
//     }

//     return chatsWithMessages;
//   }

//   // Get all chats with last messages for a specific user
//   Future<List<Map<String, dynamic>>> getUserChatsWithLastMessages(
//     String userId,
//   ) async {
//     // Get all chats
//     DataSnapshot chatsSnapshot = await _chatsRef.get();

//     List<Map<String, dynamic>> userChats = [];

//     for (var chatSnapshot in chatsSnapshot.children) {
//       String chatId = chatSnapshot.key!;
//       Map<dynamic, dynamic> chatData =
//           chatSnapshot.value as Map<dynamic, dynamic>;

//       // Check if user is a member of this chat
//       List<String> members = [];

//       if (chatData[AppConstants.members] != null) {
//         for (var member in chatData[AppConstants.members]) {
//           members.add(member.toString());
//         }
//       }

//       // Skip if user is not a member
//       if (!members.contains(userId)) continue;

//       // Create the chat object
//       ChatModel chat = ChatModel.fromMap(chatData, chatId);

//       // Get the last message
//       DataSnapshot lastMessageSnapshot =
//           await _messagesRef
//               .child(chatId)
//               .orderByChild(AppConstants.timeStamp)
//               .limitToLast(1)
//               .get();

//       Message? lastMessage;
//       if (lastMessageSnapshot.exists &&
//           lastMessageSnapshot.children.isNotEmpty) {
//         var child = lastMessageSnapshot.children.first;
//         var messageId = child.key ?? '';
//         var messageData = child.value as Map<dynamic, dynamic>;
//         lastMessage = Message.fromMap(messageData, messageId, chatId);
//       }

//       // Fetch other users' info
//       List<String> otherMembers =
//           members.where((member) => member != userId).toList();

//       userChats.add({
//         'chat': chat,
//         'lastMessage': lastMessage,
//         'otherMembers': otherMembers,
//       });
//     }

//     // Sort by last message timestamp (newest first)
//     userChats.sort((a, b) {
//       Message? msgA = a['lastMessage'] as Message?;
//       Message? msgB = b['lastMessage'] as Message?;

//       if (msgA == null && msgB == null) return 0;
//       if (msgA == null) return 1;
//       if (msgB == null) return -1;

//       return msgB.timestamp.compareTo(msgA.timestamp);
//     });

//     return userChats;
//   }

//   // Create group chat
//   Future<String> createGroupChat({
//     required List<String> members,
//     required String groupName,
//   }) async {
//     DatabaseReference newGroupChat = _chatsRef.push();
//     await newGroupChat.set({
//       AppConstants.isGroup: true,
//       AppConstants.members: members,
//       AppConstants.createdAt: ServerValue.timestamp,
//       AppConstants.groupName: groupName,
//     });
//     return newGroupChat.key!;
//   }

//   //  Get a specific chat
//   Future<ChatModel?> getChat(String chatId) async {
//     DataSnapshot snapshot = await _chatsRef.child(chatId).get();

//     if (snapshot.exists) {
//       return ChatModel.fromMap(snapshot.value as Map<dynamic, dynamic>, chatId);
//     }

//     return null;
//   }
// }
