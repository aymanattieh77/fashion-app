import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as sh;

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key, required this.child, required this.enabled});
  final Widget child;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return sh.Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: enabled,
      child: child,
    );
  }
}
