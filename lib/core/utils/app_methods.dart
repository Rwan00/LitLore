import 'package:flutter/material.dart';

void goToPage({
  required BuildContext context,
  required String routeName,
  required bool delete,
  Object? arguments,
}) {
  if (delete) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  } else {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }
}

void viewPop(BuildContext context) {
  Navigator.of(context).pop();
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

double width(context) {
  return MediaQuery.of(context).size.width;
}
