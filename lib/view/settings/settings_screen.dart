import 'package:fashion_app/view/settings/widgets/settings_body_section.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.settings),
      body: SettingsBodySection(),
    );
  }
}
