import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/map/map_cubit.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/delivery/widgets/map/build_map.dart';

import '../widgets/map/location_confirm_widget.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late final MapCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<MapCubit>(context)
      ..checkPermission()
      ..getMyCurrnetLocation();

    // cubit.checkServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: BuildMap()),
            LocationConfirmWidget(),
          ],
        ),
      ),
    );
  }
}
