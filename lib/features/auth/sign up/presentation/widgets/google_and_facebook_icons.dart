import 'package:flutter/material.dart';
import 'package:saturn/constants/assets.dart';
import 'package:saturn/core/helper/spacing.dart';



class GoogleAndFacebookIcons extends StatelessWidget {
  const GoogleAndFacebookIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(//google
          Assets.assetsImagesFacebook,
          width: 50,
          height: 50,
        ),
        horizontalSpace(10),
        Image.asset(//facebook
          Assets.assetsImagesGoogle,
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}
