import 'package:flutter/material.dart';

Widget containerWithBackground({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}
