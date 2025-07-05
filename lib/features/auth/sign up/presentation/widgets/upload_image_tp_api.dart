
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/features/auth/sign%20up/logic/cubit/sign_up_cubit.dart';

class PickImageAndUploadToApi extends StatelessWidget {
  const PickImageAndUploadToApi({super.key, required this.signUp});

  final SignUpCubit signUp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            signUp.pickImageAndUpload();
          },
          child:
              context.read<SignUpCubit>().image != null
                  ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(context.read<SignUpCubit>().image!),
                  )
                  : Image.asset(
                    Assets.assetsImagesEmptyAvater,
                    width: 100,
                    height: 100,
                  ),
        );
      },
    );
  }
}
