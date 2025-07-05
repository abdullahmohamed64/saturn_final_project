import 'package:bloc/bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/data/models/chat_title_model.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;
  List<PostModel>? posts = [];
  List<ChatTileModel> chatTileModels = [];

  Future<void> getCategoyItems({String? categoryName}) async {
    emit(GetAllCategorisLoading());

    _homeRepo
        .getCategoryItems(categoryName: categoryName)
        .then(
          (value) => value.fold((l) {
            categoryName.isNullOrEmpty() ? posts = l : null;
            emit(GetAllCategorisSuccess(arts: l));
          }, (r) => emit(GetAllCategorisFailure(errMessage: r))),
        );
  }

  List<UserModel>? allUsers = [];
  Future<void> getAllUsers({String? categoryName}) async {
    emit(GetAllUsersLoading());

    _homeRepo.getAllUsers().then(
      (value) => value.fold((l) {
        allUsers = l;
        emit(GetAllUsersSuccefully(users: l));
      }, (r) => emit(GetAllUsersFailure(errorMessage: r))),
    );
  }

  UserModel? getUserById(int userId) {
    try {
      return allUsers?.firstWhere((UserModel user) => userId == user.id);
    } catch (e) {
      return null;
    }
  }

  getListOfUsersById(String userId) async {
    emit(GetAllUsersLoading());

    chatTileModels = [];

    Map<String, MessageModel> usersMap = await ChatService().getChatedUsers(
      userId,
    );

    List<MessageModel> messages = usersMap.values.toList();

    for (int i = 0; i < usersMap.keys.length; i++) {
      //messages iterator
      UserModel? user = getUserById(int.parse(usersMap.keys.elementAt(i)));
      if (user == null) {
        continue;
      } // user loged out skip his chat

      chatTileModels.add(
        ChatTileModel(
          userImage: user.picName,
          receiverId:
              messages[i].senderId.toString() == userId
                  ? user.id.toString()
                  : userId,
          username: user.username!,
          lastMessage: messages[i].message,
          lastMessageTime: messages[i].dateTime,
          timeStamp: messages[i].timeStamp,
        ),
      );
    }
    chatTileModels.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
    if (chatTileModels.isNullOrEmpty() || chatTileModels == []) {
      emit(GetAllUsersFailure(errorMessage: 'No Chated users yet'));
    }

    emit(GetSpecificUsersSucces(lastMessageModels: chatTileModels));
  }
}

// getListOfUsersById(String userId) async {
//   emit(GetAllUsersLoading());

//   List<String> usersId = [];
//   List<MessageModel> messages = [];
//   chatTileModels = [];

//   usersId = await ChatService().getChatedUsersId(userId);
//   messages = await ChatService().getAllLastMessages(userId);

//   // Map messages by chatId
//   Map<String, MessageModel> lastMessageMap = {
//     for (var msg in messages) msg.chatId: msg,
//   };

//   for (int i = 0; i < usersId.length; i++) {
//     final uid = usersId[i];
//     final user = getUserById(int.parse(uid));
//     if (user == null) continue;

//     // Find the chat between this user and the current user
//     final chatId = await ChatService().createOrGetChat(
//       userId1: userId,
//       userId2: uid,
//     );

//     // Only add if there's a message
//     if (lastMessageMap.containsKey(chatId)) {
//       final msg = lastMessageMap[chatId]!;

//       chatTileModels.add(
//         ChatTileModel(
//           receiverId: uid,
//           username: user.username!,
//           lastMessage: msg.message,
//           lastMessageTime: msg.dateTime,
//           timeStamp: msg.timeStamp,
//         ),
//       );
//     }
//   }

//   chatTileModels.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

//   if (chatTileModels.isEmpty) {
//     emit(GetAllUsersFailure(errorMessage: 'No Chated users yet'));
//   } else {
//     emit(GetSpecificUsersSucces(lastMessageModels: chatTileModels));
//   }
// }
