import 'package:bloc/bloc.dart';
import 'package:saturn/features/favourite/data/repo/favorite_repo.dart';
import 'package:saturn/features/home/data/models/art_model.dart';

part 'get_user_favorite_arts_state.dart';

class GetUserFavoriteArtsCubit extends Cubit<GetUserFavoriteArtsState> {
  GetUserFavoriteArtsCubit(this._favouriteRepo)
    : super(GetUserFavoriteArtsInitial());
  final FavouriteRepo _favouriteRepo;
  Future<void> emitGetUserFavoriteArts() async {
    emit(GetUserFavoriteArtsLoading());

    final result = await _favouriteRepo.getUserFavoriteArts();

    result.fold(
      (errorMessage) =>
          emit(GetUserFavoriteArtsFailure(errMessage: errorMessage)),
      (favoriteModel) =>
          emit(GetUserFavoriteArtsSucces(arts: favoriteModel.arts)),
    );
  }
}
