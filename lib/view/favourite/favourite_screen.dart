import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/favourite/widgets/favourite_body_section.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.myFavorites),
      body: FavouriteBodySection(),
    );
  }
}
