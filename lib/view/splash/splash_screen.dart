import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/splash/splash_cubit.dart';

import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final SplashCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SplashCubit>(context)..start(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: cubit.animation,
          builder: (context, _) {
            return AnimatedRotation(
              duration: const Duration(
                  milliseconds: AppConstants.splashAnimationInMilli),
              turns: cubit.animation.value,
              child: SvgPicture.asset(AssetsIconPath.appIcon),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
