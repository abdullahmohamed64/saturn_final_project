import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/features/profile/logic/edit%20user%20cubit/edit_user_profile_cubit.dart';
import 'package:saturn/features/profile/logic/user%20profile%20cubit/user_profile_cubit_.dart';

class EditUserBlocListener extends StatelessWidget {
  const EditUserBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditUserProfileCubit, EditUserProfileState>(
      listener: (context, state) {
           if(state is EditUserProfileFailure){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errMessage)));
           }
           else if(state is EditUserProfilSuccess){
            context.read<UserProfileCubit>().emitGetUserProfile();
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
             context.pop();
           }
           else if(state is EditUserProfileLoading){
             Center(child: CircularProgressIndicator());
           }
           else if(state is ImageUploaded){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('image uploaded successfully')));
           }
      },
      child: SizedBox.shrink(),
    );
  }
}
