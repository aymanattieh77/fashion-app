import 'package:flutter/material.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

final List<String> privacyPoints = [
  'privacy_policy_point1',
  'privacy_policy_point2',
  'privacy_policy_point3',
  'privacy_policy_point4',
  'privacy_policy_point5',
  'privacy_policy_point6',
  'privacy_policy_point7',
  'privacy_policy_point8',
  'privacy_policy_point9',
  'privacy_policy_point10',
];

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.privacyPolicy),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppPadding.p5),
                itemCount: privacyPoints.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      size: 10,
                      color: context.primaryColor,
                    ),
                    title: TextUtils(
                      text: privacyPoints[index],
                      fontSize: 12,
                      softWrap: false,
                      maxlines: 8,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
