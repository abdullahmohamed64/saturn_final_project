import 'package:bloc/bloc.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/profile/data/models/user_profile_response_model.dart';
import 'package:saturn/features/profile/data/repo/user_profile_repo.dart';

part 'user_profile_cubit_state.dart';

class UserProfileCubit extends Cubit<UserProfileCubitState> {
  UserProfileCubit(this._userProfileRepo) : super(UserProfileCubitInitial());
  late List<PostModel> imagePosts = [];
  late List<PostModel> videosPosts = [];
  late List<PostModel> allPosts = [];
  final UserProfileRepo _userProfileRepo;
  Future<void> emitGetUserProfile() async {
    emit(UserProfileCubitLoading());
    final userProfile = await _userProfileRepo.getUserProfile();
    userProfile.fold(
      (errorMessage) => emit(UserProfileCubitFailure(message: errorMessage)),
      (userProfile) {
        allPosts = userProfile.arts!;
        filterPosts();
        emit(
          UserProfileCubitSuccesfully(userProfileResponseModel: userProfile),
        );
      },
    );
  }

  void filterPosts() {
    imagePosts.clear();
    videosPosts.clear();
    for (var post in allPosts) {
      if (post.type == 'image') {
        imagePosts.add(post);
      } else if (post.type == 'video') {
        videosPosts.add(post);
      }
    }
  }
}
