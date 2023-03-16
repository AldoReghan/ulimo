import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultBackgroundScaffold({required Scaffold scaffold}) {
  return Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/main_app_background.png"),
                fit: BoxFit.cover)),
      ),
      scaffold
    ],
  );
}
