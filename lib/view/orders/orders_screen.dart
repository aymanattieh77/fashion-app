import 'package:fashion_app/view/orders/widgets/orders_appbar.dart';
import 'package:fashion_app/view/orders/widgets/orders_body_section.dart';

import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: OrderAppbar(),
        body: OrdersBodySection(),
      ),
    );
  }
}
