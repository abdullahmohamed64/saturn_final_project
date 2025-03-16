import 'package:flutter/material.dart';
import 'package:saturn/core/helper/app_functions.dart';
import 'package:saturn/features/favourite/logic/cubit/art_state.dart';

void handleError(BuildContext context, ArtState state) {
  if (state is MakeReactFailure) {
    AppFunctions.showErrorDialog(context, "Reaction Failed", state.errMessage);
  } else if (state is CreateCommentFailure) {
    AppFunctions.showErrorDialog(context, "Comment Failed", state.errMessage);
  } else if (state is GetPostReactsAndCommentsFailure) {
    AppFunctions.showErrorDialog(context, "Data Fetch Error", state.errMessage);
  }
}
