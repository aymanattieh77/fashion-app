import 'package:flutter/material.dart';

import 'package:fashion_app/controllers/on_boarding/on_boarding_cubit.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';

import 'package:fashion_app/view/on_boarding/widget/on_boarding_widget.dart';

class OnBoardingPageview extends StatelessWidget {
  const OnBoardingPageview(
      {super.key, required this.controller, required this.onChange});
  final PageController controller;
  final Function(int) onChange;
  @override
  Widget build(BuildContext context) {
    final onBoardingList = OnBoardingCubit().onBoardingList;
    return SizedBox(
      height: context.setHeight(0.60), // 60 % device height
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        onPageChanged: onChange,
        controller: controller,
        itemCount: onBoardingList.length,
        itemBuilder: (context, index) {
          return OnBoardingWidget(
            image: onBoardingList[index].image,
            title: onBoardingList[index].title,
            description: onBoardingList[index].description,
          );
        },
      ),
    );
  }
}
