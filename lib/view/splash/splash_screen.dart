import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';

import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  final _prefs = getIt<AppPrefs>();
  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return AnimatedRotation(
              duration: const Duration(
                  milliseconds: AppConstants.splashAnimationInMilli),
              turns: _animation.value,
              child: SvgPicture.asset(AssetsIconPath.appIcon),
            );
          },
        ),
      ),
    );
  }

  _splashTimer() {
    Future.delayed(
      const Duration(seconds: AppConstants.splashTimerInSec),
      _goNext,
    );
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: AppConstants.splashAnimationInMilli),
    );
    _animation = Tween<double>(begin: 4, end: 1).animate(_animationController);
    _animationController.forward();
  }

  _goNext() {
    if (_prefs.isCompleteOnBoarding()) {
      if (_prefs.isUserLoginIn()) {
        BlocProvider.of<UserCubit>(context).getUserProfileById();
        context.goToNamed(route: Routes.home, replacement: true);
      } else {
        context.goToNamed(route: Routes.auth, replacement: true);
      }
    } else {
      context.goToNamed(route: Routes.onBoarding, replacement: true);
    }
  }

  _start() {
    _splashTimer();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }
}
