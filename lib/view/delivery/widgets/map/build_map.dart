import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fashion_app/controllers/map/map_cubit.dart';

class BuildMap extends StatelessWidget {
  const BuildMap({super.key});

  @override
  Widget build(BuildContext context) {
    MapCubit cubit = BlocProvider.of<MapCubit>(context);
    return Stack(
      children: [
        BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            return GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: cubit.markers,
              onTap: cubit.onMapTap,
              mapType: MapType.normal,
              initialCameraPosition: cubit.getInitalCameraPosition,
              onMapCreated: cubit.onMapCreated,
            );
          },
        ),
      ],
    );
  }
}
