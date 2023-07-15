import 'package:equatable/equatable.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/controllers/user/user_cubit.dart';
import 'package:fashion_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/services/service_locator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  late Animation<double> animation;
  late AnimationController _animationController;
  final _prefs = getIt<AppPrefs>();

  // splash screen start

  start(BuildContext context, TickerProvider tickerProvider) {
    _splashTimer(context);
    _initAnimation(tickerProvider);
  }

  _initAnimation(TickerProvider tickerProvider) {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration:
          const Duration(milliseconds: AppConstants.splashAnimationInMilli),
    );
    animation = Tween<double>(begin: 4, end: 1).animate(_animationController);
    _animationController.forward();
  }

  _goNext(BuildContext context) {
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

  _splashTimer(BuildContext context) {
    Future.delayed(
      const Duration(seconds: AppConstants.splashTimerInSec),
      () {
        _goNext(context);
      },
    );
  }

  void dispose() {
    _animationController.stop();
    _animationController.dispose();
  }
}
