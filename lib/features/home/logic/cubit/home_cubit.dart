import 'package:bloc/bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/features/auth/models/user_model.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;
  List<ArtModel>? arts = [];
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
}
