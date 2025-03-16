import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saturn/features/favourite/data/models/add_like_response_model.dart';
import 'package:saturn/features/favourite/data/repo/favourite_repo.dart';

part 'favourite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._favouriteRepo) : super(FavouriteInitial());
  final FavouriteRepo _favouriteRepo;

  void emitReact({required int artId}) async {
    _favouriteRepo
        .react(artId: artId)
        .then(
          (value) => value.fold(
            (l) => emit(ReactedSuccefully(addLikeResponseModel: l)),
            (r) => emit(ReactedFailure(errMessage: r)),
          ),
        );
  }
}
