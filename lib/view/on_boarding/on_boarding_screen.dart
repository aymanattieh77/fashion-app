import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/on_boarding/on_boarding_cubit.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/on_boarding/widget/on_boarding_pageview.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<OnBoardingCubit>(context)..completeOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<OnBoardingCubit, OnBoardingState>(
                builder: (context, state) {
                  return _pageNumberText();
                },
              ),
              InkWell(
                onTap: _skipButton,
                child: const TextUtils(
                  text: AppStrings.skip,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.s55),
          OnBoardingPageview(
            controller: cubit.controller,
            onChange: cubit.onPageChange,
          ),
          const SizedBox(height: AppSizes.s30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 79,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: AppColor.orange,
            ),
            onPressed: _nextButton,
            child: _buttonText(),
          ),
        ],
      ),
    );
  }

  Widget _buttonText() {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return TextUtils(text: cubit.buttonText(), color: AppColor.white);
      },
    );
  }

  Widget _pageNumberText() {
    return Row(
      children: [
        Text(
          '${cubit.pageIndex + 1}',
          style: const TextStyle(color: AppColor.black),
        ),
        Text(
          '/3',
          style: TextStyle(
              color: cubit.pageIndex == 2 ? Colors.black : AppColor.black50),
        ),
      ],
    );
  }

  void _nextButton() {
    cubit.nextButton(context);
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  void _skipButton() {
    cubit.skipButton(context);
  }
}
