import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/controllers/search/search_cubit.dart';
import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.textFieldTap,
    this.enabled,
  });

  final Function()? textFieldTap;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Row(
        children: [
          const SizedBox(width: AppSizes.s20),
          SizedBox(
            height: 13,
            width: 13,
            child: SvgPicture.asset(
              AssetsIconPath.search,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: TextField(
              onChanged: (val) {
                _onChange(context, val);
              },
              onSubmitted: (val) {
                _onSubmit(context, val);
              },
              autofocus: true,
              style: TextStyle(color: Theme.of(context).primaryColor),
              enabled: enabled,
              decoration: InputDecoration(
                hintText: AppStrings.searchItems.tr(),
                hintStyle:
                    TextStyle(color: Theme.of(context).primaryColorLight),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: enabled != null && enabled == false
                ? null
                : () {
                    _showFillter(context);
                  },
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p20 - 10),
              decoration: BoxDecoration(
                  color: AppColor.orange,
                  borderRadius: BorderRadius.circular(12)),
              child: SvgPicture.asset(
                AssetsIconPath.filter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onChange(BuildContext context, String value) {
    BlocProvider.of<SearchCubit>(context).startSearch(context, value);
  }

  _onSubmit(BuildContext context, String value) {
    BlocProvider.of<SearchCubit>(context).onSubmit(context, value);
  }

  _showFillter(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).showFilter(context);
  }
}
