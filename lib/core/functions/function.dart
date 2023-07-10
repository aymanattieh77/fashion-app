import 'package:easy_localization/easy_localization.dart';
import 'package:fashion_app/core/extensions/theme_extension.dart';
import 'package:fashion_app/core/utils/colors.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackMessage(BuildContext context, {required String message}) {
  final SnackBar snackBar = SnackBar(
    content: TextUtils(text: message..trim().tr(), color: AppColor.white),
    backgroundColor: AppColor.orange,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showToastMessage(String message) async {
// Toast with No Build Context (Android & iOS)
  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.orange,
    textColor: AppColor.white,
    fontSize: 16.0,
  );
}

showCustomDialog(BuildContext context, Widget child) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: context.scaffoldBackgroundColor,
      child: child,
    ),
  );
}

bool _isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

void dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

showCustomBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    builder: (context) => child,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).cardColor,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
