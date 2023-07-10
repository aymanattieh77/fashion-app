import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fashion_app/controllers/cart/cart_cubit.dart';

import 'package:fashion_app/core/extensions/theme_extension.dart';

import 'package:fashion_app/config/routes/route_context.dart';
import 'package:fashion_app/config/routes/routes.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/home/widgets/main/menu_widget.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const MenuIconWidget(),
      title: const TextUtils(
        text: '\u{00A9} 15/2 New Texas',
        fontSize: 14,
        tr: false,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          //cart icon
          onPressed: () {
            _goToCartScreen(context);
          },
          icon: Badge(
            alignment: Alignment.topRight,
            label: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return _getProductsInCart(context);
              },
            ),
            child: SvgPicture.asset(
              AssetsIconPath.shoppingCart,
              colorFilter:
                  ColorFilter.mode(context.primaryColor, BlendMode.srcIn),
            ),
          ),
        ),
        IconButton(
          // notifications icon
          onPressed: () {
            _goToNotificationScreen(context);
          },
          icon: Badge(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AssetsIconPath.notifications,
              colorFilter:
                  ColorFilter.mode(context.primaryColor, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  _getProductsInCart(BuildContext context) {
    return Text(
      BlocProvider.of<CartCubit>(context).productsInCart,
      style: const TextStyle(
        color: AppColor.white,
        fontSize: 12,
      ),
    );
  }

  _goToCartScreen(BuildContext context) {
    context.goToNamed(route: Routes.cart);
  }

  _goToNotificationScreen(BuildContext context) {
    context.goToNamed(route: Routes.notification);
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.s55);
}
