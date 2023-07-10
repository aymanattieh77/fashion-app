import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/state_renderer/failure/full_screen_failure_state.dart';
import 'package:fashion_app/view/widgets/state_renderer/loading/full_screen_loading_state.dart';

showStateRenderder(BuildContext context, Widget state) async {
  await showDialog(
    context: context,
    builder: (context) => state,
  );
}

showFullScreenErrorState(BuildContext context, String errorMessage) {
  showStateRenderder(
      context,
      FullScreenFailureState(
          message: errorMessage,
          press: () {
            Phoenix.rebirth(context);
          }));
}

Widget loadingCircularWidget() {
  return const Center(
    child: CircularProgressIndicator(
      color: AppColor.orange,
    ),
  );
}

showFullScreenLoadingState(BuildContext context) {
  showStateRenderder(context, const FullScreenLoadingState());
}
