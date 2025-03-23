import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saturn/core/helper/spacing.dart';
import 'package:saturn/core/theming/app_colors.dart';
import 'package:saturn/core/theming/app_textstyles.dart';
import 'package:saturn/core/widgets/custom_gridview_shimmer.dart';
import 'package:saturn/features/home/data/models/art_model.dart';
import 'package:saturn/features/profile/logic/cubit/user_profile_cubit_.dart';
import 'package:saturn/features/profile/presentaion/widgets/deep_blue_container.dart';
import 'package:saturn/features/profile/presentaion/widgets/navigation_text_widget.dart';
import 'package:saturn/features/profile/presentaion/widgets/user_image.dart';

import '../widgets/gridview_container.dart';

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






