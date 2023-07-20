import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqList = getFAQ();
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.faq),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            iconColor: AppColor.orange,
            collapsedIconColor: context.primaryColor,
            title: TextUtils(
              text: faqList[index]['question'] as String,
              fontSize: 12,
              maxlines: 6,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextUtils(
                  text: faqList[index]['answer'] as String,
                  fontSize: 12,
                  maxlines: 6,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<Map<String, String>> getFAQ() {
  return List.generate(13, (index) {
    return {
      'question': "faq_question${index + 1}",
      'answer': "faq_answers${index + 1}",
    };
  }).toList();
}
