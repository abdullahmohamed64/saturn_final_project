import 'package:bloc/bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/auth/sign%20up/presentation/widgets/custom_gender_drop_down_button.dart';
import 'package:saturn/features/chat/data/models/chat_service.dart';
import 'package:saturn/features/chat/data/models/chat_title_model.dart';
import 'package:saturn/features/chat/data/models/message_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;
  List<ArtModel>? arts = [];
  List<ChatTileModel> chatTileModels = [];

  Future<void> getCategoyItems({String? categoryName}) async {
    emit(GetAllCategorisLoading());

    _homeRepo
        .getCategoryItems(categoryName: categoryName)
        .then(
          (value) => value.fold((l) {
            categoryName.isNullOrEmpty() ? arts = l : null;
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
    List<UserModel> chatedUsers = [];
    List<String> usersId = [];
    List<MessageModel> messages = [];
    chatTileModels = [];
    usersId = await ChatService().getChatedUsersId(userId);

    messages = await ChatService().getAllLastMessages(userId);

    for (int i = 0; i < usersId.length; i++) {
      UserModel user = getUserById(int.parse(usersId[i]))!;
      chatTileModels.add(
        ChatTileModel(
          receiverId: usersId[i],
          username: user.username!,
          lastMessage: messages[i].message,
          lastMessageTime: messages[i].dateTime,
          timeStamp: messages[i].timeStamp,
        ),
      );
    }
    chatTileModels.sort(
      (a, b) => b.timeStamp.compareTo(a.timeStamp),
    );
    if (chatedUsers.isNullOrEmpty()) {
      emit(GetAllUsersFailure(errorMessage: 'No Chated users yet'));
    }

    emit(GetSpecificUsersSucces(lastMessageModels: chatTileModels));
  }
}
