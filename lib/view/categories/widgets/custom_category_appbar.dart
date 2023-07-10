import 'package:fashion_app/controllers/category_product/category_product_cubit.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/core/utils/assets.dart';
import 'package:fashion_app/core/utils/colors.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCategoryAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomCategoryAppbar(
      {super.key, required this.title, required this.categoryId});
  final String title;
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.back();
        },
        icon: Icon(Icons.arrow_back_ios, color: context.primaryColor),
      ),
      centerTitle: true,
      title: TextUtils(
        text: title,
        fontSize: 20,
        fontWe: FontWe.medium,
      ),
      actions: [
        InkWell(
          onTap: () {
            BlocProvider.of<CategoryProductCubit>(context)
                .showFilter(context, categoryId);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.circular(12)),
            child: SvgPicture.asset(
              AssetsIconPath.filter,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
