import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/view/widgets/common/custom_appbar.dart';
import 'package:fashion_app/view/widgets/state_renderer/empty_state.dart';
import 'package:flutter/material.dart';

class NotiFicationScreen extends StatelessWidget {
  const NotiFicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppbar(title: AppStrings.notification),
        body: EmptyState(
          icon: Icons.notifications_none,
          message: AppStrings.noNotificationsFound,
        ));
  }
}
