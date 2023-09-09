import 'package:flutter/material.dart';

class UiUtils {
  const UiUtils._();

  static double getMaxWidth(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide;
  }
}