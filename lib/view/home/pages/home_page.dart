import 'package:flutter/material.dart';

import 'package:fashion_app/view/home/widgets/home/custom_home_appbar.dart';
import 'package:fashion_app/view/home/widgets/home/home_body_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomHomeAppbar(),
      body: HomeBodySection(),
    );
  }
}
