import 'package:flutter/material.dart';
import 'package:saturn/core/helper/extension.dart';
import 'package:saturn/core/routing/routes.dart';
import 'package:saturn/core/theming/app_textstyles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushReplacementNamed(Routes.signUpPage);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account',
              style: AppTextstyles.font14GreyRegular,
            ),
            TextSpan(
              text: ' sign up here',
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
