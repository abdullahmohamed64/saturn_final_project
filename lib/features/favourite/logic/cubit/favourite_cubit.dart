import 'package:bloc/bloc.dart';
import 'package:saturn/features/favourite/data/models/favorite_model.dart';
import 'package:saturn/features/favourite/data/repo/favourite_repo.dart';

part 'favourite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._favouriteRepo) : super(FavouriteInitial());
  final FavouriteRepo _favouriteRepo;

  void emitReact({required int artId}) async {
    emit(ReactedLoading());
    _favouriteRepo
        .react(artId: artId)
        .then(
          (value) => value.fold(
            (l) => emit(ReactedSuccefully(favouriteRsponseModel: l)),
            (r) => emit(ReactedFailure(errMessage: r)),
          ),
        );
  }

  void emitGetPostReact({required int artId}) async {
    emit(ReactedLoading());

    _favouriteRepo
        .getPostReact(artId: artId)
        .then(
          (value) => value.fold(
            (l) => emit(ReactedSuccefully(favouriteRsponseModel: l)),
            (r) => emit(ReactedFailure(errMessage: r)),
          ),
        );
  }
}
