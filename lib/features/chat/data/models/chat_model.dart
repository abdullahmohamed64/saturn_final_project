import 'package:saturn/core/theming/app_constants.dart';

class ChatModel {
  final String id;
  final bool isGroup;
  final List<String> members;
  final int createdAt;
  final String? groupName;

  ChatModel({
    required this.id,
    required this.isGroup,
    required this.members,
    required this.createdAt,
    this.groupName,
  });

  factory ChatModel.fromMap(Map<dynamic, dynamic> map, String chatId) {
    List<String> membersList = [];
    if (map[AppConstants.members] != null) {
      for (var member in map[AppConstants.members]) {
        membersList.add(member.toString());
      }
    }

    return ChatModel(
      id: chatId,
      isGroup: map[AppConstants.isGroup] ?? false,
      members: membersList,
      createdAt: map[AppConstants.createdAt] ?? 0,
      groupName: map[AppConstants.groupName],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConstants.isGroup: isGroup,
      AppConstants.members: members,
      AppConstants.createdAt: createdAt,
      if (groupName != null) AppConstants.groupName: groupName,
    };
  }
}
