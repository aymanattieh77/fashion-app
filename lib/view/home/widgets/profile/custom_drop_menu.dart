import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';
import 'package:fashion_app/core/utils/strings.dart';

class CustomDropMenu extends StatelessWidget {
  const CustomDropMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      elevation: 8,
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryColor,
      ),
      items: <String>[AppStrings.settings.tr(), AppStrings.accountSettings.tr()]
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {
        if (_ == AppStrings.settings.tr()) {
          context.goToNamed(route: Routes.settings);
        }
        if (_ == AppStrings.accountSettings.tr()) {
          context.goToNamed(route: Routes.account);
        }
      },
    );
  }
}
