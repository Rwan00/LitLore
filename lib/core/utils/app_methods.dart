import 'package:flutter/material.dart';

void goAndDelete({required BuildContext context, required String routeName}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    (Route<dynamic> route) => false,
    
  );
}

double  height(context){
  return MediaQuery.of(context).size.height;
}
double width(context){
  return MediaQuery.of(context).size.width;
}