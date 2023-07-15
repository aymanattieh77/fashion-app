import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/main/main_cubit.dart';
import 'package:fashion_app/view/home/widgets/main/custom_advanced_drawer.dart';
import 'package:fashion_app/view/home/widgets/main/custom_drawer.dart';
import 'package:fashion_app/view/home/widgets/main/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainCubit mainCubit;

  @override
  void initState() {
    super.initState();

    mainCubit = BlocProvider.of<MainCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAdvancedDrawer(
      controller: mainCubit.advancedDrawerController,
      drawer: const CustomDrawer(),
      child: _screenContent(),
    );
  }

  Widget _screenContent() {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: mainCubit.cutrentIndex,
            children: mainCubit.pageList,
          ),
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: mainCubit.cutrentIndex,
            onTap: mainCubit.onPageChange,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    mainCubit.dispose();
    super.dispose();
  }
}
