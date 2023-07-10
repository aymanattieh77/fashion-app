import 'package:fashion_app/core/utils/constants.dart';
import 'package:fashion_app/view/widgets/common/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

screen(Widget child, [PageTransitionType? type]) {
  // return MaterialPageRoute(
  //   builder: (context) => child,
  // );
  return PageTransition(
    child: child,
    type: type ?? PageTransitionType.rightToLeftWithFade,
    curve: Curves.linear,
    duration: const Duration(milliseconds: AppConstants.pageTransitionInMilli),
    alignment: Alignment.center,
  );
}

unKnowunScreen() {
  return MaterialPageRoute(
    builder: (context) => const Scaffold(
      body: Center(
        child: TextUtils(
          text: 'UnKnowun Screen',
          fontSize: 30,
          tr: false,
        ),
      ),
    ),
  );
}

extension RouteContextExtension on BuildContext {
  // Navigation functions
  goTo(Widget child, [bool replacement = false]) {
    if (replacement) {
      Navigator.of(this).pushReplacement(screen(child));
    } else {
      Navigator.of(this).push(screen(child));
    }
  }

  goToNamed({required String route, bool replacement = false, Object? args}) {
    if (replacement) {
      Navigator.of(this).pushReplacementNamed(route, arguments: args);
    } else {
      Navigator.of(this).pushNamed(route, arguments: args);
    }
  }

  back() {
    Navigator.of(this).pop();
  }

  pushRemoveUntil(String route) {
    Navigator.of(this).pushNamedAndRemoveUntil(route, (route) => false);
  }
}
