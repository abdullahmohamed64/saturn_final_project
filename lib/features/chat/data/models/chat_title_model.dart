class ChatTileModel {
  final String receiverId;
  final String username;
  final String? userImage; // URL or local path
  final String lastMessage;
  final String lastMessageTime;
  final bool isUnread; // optional for badge, if needed
  final int timeStamp;//used for sorting
  
  

  ChatTileModel({
    required this.timeStamp,
    required this.receiverId,
    required this.username,
    this.userImage,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isUnread = false,
  });
}
