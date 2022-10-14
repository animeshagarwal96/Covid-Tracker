import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lighttheme(BuildContext context) => ThemeData(
        primaryColor: creamColor,
        canvasColor: Colors.white,
        hoverColor: Vx.hexToColor("#E2E5DE"),
        indicatorColor: Colors.black,
        fontFamily: GoogleFonts.openSans().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: creamColor, fontSize: 20),
        ),
      );

  static Color themeColor = Vx.hexToColor("#1da1f2");
  static Color creamColor = Vx.hexToColor("#E7E6E2");
  static Color containerColor = const Color(0xfff5f5f5);
}
