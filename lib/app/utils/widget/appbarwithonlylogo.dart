import 'package:flutter/material.dart';

PreferredSizeWidget appbarWithOnlyLogo() {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Image.asset("assets/logo.png", height: 40),
    automaticallyImplyLeading: false,
  );
}
