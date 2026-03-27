import 'package:flutter/material.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/features/favourite/logic/cubit/art_state.dart';

void handleError(BuildContext context, ArtState state) {
  if (state is MakeReactFailure) {
    AppFunctions.showCustomDialog(context, "Reaction Failed", state.errMessage);
  } else if (state is CreateCommentFailure) {
    AppFunctions.showCustomDialog(context, "Comment Failed", state.errMessage);
  } else if (state is GetPostReactsAndCommentsFailure) {
    AppFunctions.showCustomDialog(context, "Data Fetch Error", state.errMessage);
  }
}
