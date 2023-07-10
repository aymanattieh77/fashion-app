import 'package:flutter/material.dart';

import 'package:fashion_app/view/home/widgets/profile/custom_profile_appbar.dart';
import 'package:fashion_app/view/home/widgets/profile/profile_body_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomProfileAppbar(),
      body: ProfileBodySection(),
    );
  }
}
