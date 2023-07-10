import 'package:flutter/material.dart';

import 'package:fashion_app/view/home/widgets/catalog/catalog_appbar.dart';
import 'package:fashion_app/view/home/widgets/catalog/catalog_body_section.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CatalogAppbar(),
        body: CatalogBodySection(),
      ),
    );
  }
}
