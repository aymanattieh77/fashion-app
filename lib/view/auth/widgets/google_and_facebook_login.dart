import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/values.dart';

class GoogleAndFacebookLogin extends StatelessWidget {
  const GoogleAndFacebookLogin(
      {super.key, this.facebookLogin, this.googleLogin});
  final Function()? facebookLogin;
  final Function()? googleLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: facebookLogin,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SvgPicture.asset(AssetsIconPath.facebook),
          ),
        ),
        const SizedBox(width: AppSizes.s15),
        InkWell(
          onTap: googleLogin,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SvgPicture.asset(AssetsIconPath.google),
          ),
        ),
      ],
    );
  }
}
