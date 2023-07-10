import 'package:fashion_app/view/search/widgets/search_body_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';

import '../widgets/common/back_to_top_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit searchCubit;
  @override
  void initState() {
    super.initState();
    searchCubit = BlocProvider.of<SearchCubit>(context)..start(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: AppStrings.search),
      body: const SearchBodySection(),
      floatingActionButton:
          BackToTopButton(scrollController: searchCubit.scrollController),
    );
  }

  @override
  void dispose() {
    searchCubit.dispose();
    super.dispose();
  }
}
