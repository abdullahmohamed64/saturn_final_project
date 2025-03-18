import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_gridview_shimmer.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/home/presentation/widgets/custom_home_arts_grid_view.dart';
import 'package:saturn/features/profile/logic/cubit/user_profile_cubit_.dart';

const List<String> textList = ['All', 'Photos', 'Videos'];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<UserProfileCubit>().emitGetUserProfile();

    super.initState();
  }

  late List<ArtModel> artList = [];
  String clickedValue = '';
  @override
  Widget build(BuildContext context) {
    final mdQry = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.mainPurple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: mdQry.height / 7),
          child: BlocConsumer<UserProfileCubit, UserProfileCubitState>(
            listener: (context, state) {
              if (state is UserProfileCubitSuccesfully) {
                setState(() {
                  artList = state.userProfileResponseModel.arts!;
                });
              }
            },
            builder: (context, state) {
              if (state is UserProfileCubitSuccesfully) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: [
                    DeepBuleContainer(mdQry: mdQry),
                    UserImage(),

                    Positioned(
                      bottom: 20.h,
                      child: SizedBox(
                        height: mdQry.height * 4 / 7,
                        width: mdQry.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  textList.map((val) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          clickedValue = val;
                                          if (val == 'Photos') {
                                            artList =
                                                context
                                                    .read<UserProfileCubit>()
                                                    .imagePosts;
                                          } else if (val == 'Videos') {
                                            artList =
                                                context
                                                    .read<UserProfileCubit>()
                                                    .videosPosts;
                                          } else {
                                            artList =
                                                context
                                                    .read<UserProfileCubit>()
                                                    .allPosts;
                                          }
                                        });
                                      },
                                      child: TextWidget(
                                        text: val,
                                        clickedTex: clickedValue,
                                      ),
                                    );
                                  }).toList(),
                            ),
                            verticalSpace(10),
                            GridViewContainer(mdQry: mdQry, arts: artList),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (State is UserProfileCubitLoading) {
                return CustomGridViewShimmer();
              } else {
                return Center(
                  child: Text(
                    'Failed to fetch posts',
                    style: AppTextstyles.font24BlueBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text, required this.clickedTex});
  final String text;
  final String clickedTex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.w),
      child:
          clickedTex == text
              ? Text(
                text,
                style: AppTextstyles.font16WhiteMeduim.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                ),
              )
              : Text(text, style: AppTextstyles.font16WhiteMeduim),
    );
  }
}

class GridViewContainer extends StatelessWidget {
  const GridViewContainer({super.key, required this.mdQry, required this.arts});

  final Size mdQry;
  final List<ArtModel> arts;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      height: mdQry.height * 3 / 6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(64.r)),
      child: CustomHomeArtsGridView(artModels: arts),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,

      child: CircleAvatar(
        backgroundColor: AppColors.white,
        radius: 50.r,
        child: CircleAvatar(
          backgroundImage: AssetImage(Assets.assetsImagesDesign),
          radius: 45.r,
        ),
      ),
    );
  }
}

class DeepBuleContainer extends StatelessWidget {
  const DeepBuleContainer({super.key, required this.mdQry});

  final Size mdQry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mdQry.height * 5 / 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),

        color: AppColors.deepPurple,
      ),
    );
  }
}
