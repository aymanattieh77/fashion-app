import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/core/extensions/string_extension.dart';
import 'package:fashion_app/core/utils/strings.dart';
import 'package:fashion_app/core/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum FieldType { text, email, password }

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    this.icon,
    required this.hint,
    required this.filedType,
    this.controller,
  });

  final String? icon;
  final String hint;
  final FieldType filedType;
  final TextEditingController? controller;
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
      child: Row(
        children: [
          if (widget.icon != null)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p5, vertical: AppPadding.p5),
              decoration: BoxDecoration(
                color: AppColor.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: AppSizes.s24,
                width: AppSizes.s24,
                child: SvgPicture.asset(widget.icon!),
              ),
            ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).primaryColor),
              obscureText:
                  widget.filedType == FieldType.password ? obsecure : false,
              controller: widget.controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseFillTheField.tr();
                } else {
                  if (widget.filedType == FieldType.text) {
                    return value.isVaildName
                        ? null
                        : AppStrings.isNotVaildName.tr();
                  } else if (widget.filedType == FieldType.email) {
                    return value.isValidEmail
                        ? null
                        : AppStrings.emailIsNotValid.tr();
                  } else {
                    return value.isVaildPassword
                        ? null
                        : AppStrings.passwordIsTooShort.tr();
                  }
                }
              },
              decoration: InputDecoration(
                hintText: widget.hint.tr(),
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p5,
                  vertical: AppPadding.p15,
                ),
                suffix: widget.filedType == FieldType.password
                    ? _showPassword()
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showPassword() {
    return InkWell(
      onTap: () {
        setState(() {
          obsecure = !obsecure;
        });
      },
      child: const Text(
        'Show',
        style: TextStyle(fontSize: 10, color: AppColor.gray),
      ),
    );
  }
}
