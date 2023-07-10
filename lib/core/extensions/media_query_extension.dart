import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  double fullWidth() {
    return MediaQuery.of(this).size.width;
  }

  double fullHeight() {
    return MediaQuery.of(this).size.height;
  }

  double setWidth(double value) {
    /// value must between 0.0 -1.0
    return MediaQuery.of(this).size.width * value;
  }

  double setHeight(double value) {
    /// value must between 0.0 -1.0
    return MediaQuery.of(this).size.height * value;
  }
}
