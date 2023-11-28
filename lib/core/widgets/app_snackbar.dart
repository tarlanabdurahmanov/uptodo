import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

appSnackBar(
  BuildContext context, {
  required String text,
  required AnimatedSnackBarType type,
}) {
  return AnimatedSnackBar.material(
    text,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    snackBarStrategy: RemoveSnackBarStrategy(),
    duration: const Duration(seconds: 2),
  ).show(context);
}
