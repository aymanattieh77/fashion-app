import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:fashion_app/controllers/rating/rating_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/custom_elevated_button.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.rateOurApp),
      body: Center(
        child: RatingForm(),
      ),
    );
  }
}

class RatingForm extends StatelessWidget {
  const RatingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, double>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextUtils(
                text: AppStrings.howWouldrateOurApp,
                fontSize: 25,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: state,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: AppColor.orange,
                ),
                onRatingUpdate: (rating) {
                  BlocProvider.of<RatingCubit>(context).setRating(rating);
                },
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                label: AppStrings.submitRating,
                press: () {
                  context.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
