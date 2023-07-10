import 'package:fashion_app/controllers/main/main_cubit.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: BlocProvider.of<MainCubit>(context).handleMenuButtonPressed,
      icon: SvgPicture.asset(
        AssetsIconPath.menu,
        colorFilter:
            ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
      ),
    );
  }
}
