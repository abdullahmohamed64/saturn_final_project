import 'package:flutter/material.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushReplacementNamed(Routes.signInPage);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account?',
              style: AppTextstyles.font14GreyRegular,
            ),
            TextSpan(
              text: ' Sign In here',
              style: AppTextstyles.font14GreyRegular.copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
