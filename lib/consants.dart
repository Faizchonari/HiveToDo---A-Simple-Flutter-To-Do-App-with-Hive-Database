import 'package:flutter/material.dart';

//Theme colors
const Color kPrimaryColor = Color(0xFF191970);
const Color kSecondaryColor = Color(0xFFC0C0C0);
const Color kAccentColor = Color(0xFFFFA500);

LinearGradient backGroundgradiant() {
  return const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        kSecondaryColor,
        Color.fromARGB(136, 228, 222, 222),
        Color.fromARGB(133, 253, 252, 252),
      ]);
}
