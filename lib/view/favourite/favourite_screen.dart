import 'package:fashion_app/controllers/favourite/favourite_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/favourite/widgets/favourite_body_section.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavouriteCubit>(context).getFavouritesProducts();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(title: AppStrings.myFavorites),
      body: FavouriteBodySection(),
    );
  }
}
