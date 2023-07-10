import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullScreenLoadingState extends StatelessWidget {
  const FullScreenLoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/jsons/loading.json'),
            ],
          ),
        ),
      ),
    );
  }
}
