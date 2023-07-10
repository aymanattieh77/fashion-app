import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/home/widgets/profile/personal_information_section.dart';
import 'package:fashion_app/view/home/widgets/profile/profile_header_section.dart';
import 'package:fashion_app/view/home/widgets/profile/rating_order_progress_section.dart';

class ProfileBodySection extends StatelessWidget {
  const ProfileBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderSection(),
          SizedBox(height: AppSizes.s20),
          RatingOrderProgressSection(),
          SizedBox(height: AppSizes.s20),
          PersonalInformationSection(),
        ],
      ),
    );
  }
}
