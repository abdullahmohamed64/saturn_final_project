// import 'package:bloc/bloc.dart';

// import 'package:saturn/features/auth/models/user_model.dart';
// import 'package:saturn/features/chat/data/chat%20repo/chat_repo.dart';

// part 'chat_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   ChatCubit(this.chatRepo) : super(ChatInitial());
//   final ChatRepo chatRepo;
//   List<UserModel>?allUsers = [];
//   Future<void> getAllUsers({String? categoryName}) async {
//     emit(GetAllUsersLoading());

//     chatRepo.getAllUsers().then(
//       (value) => value.fold(
//         (l){
//           allUsers = l;
//            emit(GetAllUsersSuccefully(users: l));},
//         (r) => emit(GetAllUsersFailure(errorMessage: r)),
//       ),
//     );
//   }
 
//  UserModel? getUserById (int userId){
//   try {
//     return allUsers?.firstWhere((UserModel user)=> userId == user.id);
//   } catch (e) {
//     return null;
//   }
//  }
// }
