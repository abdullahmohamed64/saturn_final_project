import 'package:bloc/bloc.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/data/models/categorys_response_model.dart';
import 'package:saturn/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;

  Future<void> getCategoyItems({String? categoryName}) async {
    emit(GetAllCategorisLoading());

    _homeRepo.getCategoryItems(categoryName: categoryName).then(
      (value) => value.fold(
        (l) => emit(GetAllCategorisSuccess(arts: l)),
        (r) => emit(GetAllCategorisFailure(errMessage: r)),
      ),
    );
  }
}
