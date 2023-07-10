import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/services/prefs.dart';
import 'package:fashion_app/config/services/service_locator.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/strings.dart';

import '../../config/routes/routes.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  final controller = PageController();

  int pageIndex = 0;

  final onBoardingList = [
    OnboardingInputs(
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDescription1,
      image: AssetsIconPath.onBoarding1,
    ),
    OnboardingInputs(
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDescription2,
      image: AssetsIconPath.onBoarding2,
    ),
    OnboardingInputs(
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDescription3,
      image: AssetsIconPath.onBoarding3,
    ),
  ];

  onPageChange(int index) {
    pageIndex = index;

    emit(OnBoardingInitial());
  }

  String buttonText() {
    return pageIndex == 2 ? AppStrings.getStarted : AppStrings.next;
  }

  void nextButton(BuildContext context) {
    controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);

    onPageChange(controller.page!.toInt());

    if (pageIndex == 2) {
      context.goToNamed(route: Routes.auth, replacement: true);
    }
  }

  skipButton(BuildContext context) {
    context.goToNamed(route: Routes.auth, replacement: true);
  }

  completeOnBoarding() async {
    await getIt<AppPrefs>().completeOnBoarding();
  }

  dispose() {
    controller.dispose();
  }
}

class OnboardingInputs {
  final String title;
  final String description;
  final String image;

  OnboardingInputs({
    required this.title,
    required this.description,
    required this.image,
  });
}
