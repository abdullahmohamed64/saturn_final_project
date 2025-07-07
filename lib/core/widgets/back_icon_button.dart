
import 'package:flutter/material.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_colors.dart';

class CustomBackIconButton extends StatelessWidget {
  const CustomBackIconButton({
    super.key, this.onPressed,
  });
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundColor: AppColors.arrowBackBakgroundColor,
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.arrowBackColor,
        ),
      ),
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}
