import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/controllers/user/user_cubit.dart';

import 'package:fashion_app/core/extensions/media_query_extension.dart';
import 'package:fashion_app/core/functions/state_renderer.dart';

import 'package:fashion_app/core/utils/utils.dart';
import 'package:fashion_app/core/utils/values.dart';

import 'package:fashion_app/view/widgets/common/text_utils.dart';

class PersonalInformationSection extends StatelessWidget {
  const PersonalInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: TextUtils(
            text: AppStrings.personalInformation,
            fontSize: 18,
            fontWe: FontWe.medium,
          ),
        ),
        const SizedBox(height: AppSizes.s10),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (cubit.user == null) {
              return loadingCircularWidget();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Card(
                elevation: 15,
                child: Container(
                  color: Theme.of(context).cardColor,
                  height: context.setHeight(0.23),
                  padding: const EdgeInsets.all(AppPadding.p20 - 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _rowText(
                        label: AppStrings.name,
                        value: cubit.user!.username,
                      ),
                      _rowText(
                        label: AppStrings.email,
                        value: cubit.user!.email,
                      ),
                      _rowText(
                        label: AppStrings.location,
                        value: cubit.user!.location!,
                      ),
                      _rowText(
                        label: AppStrings.zipcode,
                        value: cubit.user!.zipCode!,
                      ),
                      _rowText(
                        label: AppStrings.phoneNumber,
                        value: cubit.user!.phoneNumber!,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _rowText({required String label, required String value}) {
    return Row(
      children: [
        TextUtils(
          text: label,
          fontSize: 12,
          color: AppColor.gray,
        ),
        const Spacer(),
        TextUtils(
          tr: false,
          text: value,
          fontSize: 12,
          fontWe: FontWe.semiBold,
        ),
      ],
    );
  }
}
