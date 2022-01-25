import 'package:divide_ai/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DivideAí',
    theme: ThemeData(
      backgroundColor: Colors.white,
      primaryColor: const Color(0xFF00E4A7),
      accentColor: const Color(0xFF00E4A7),
      textTheme: GoogleFonts.nunitoTextTheme(),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Color(0xFF00E4A7),
        ),
      ),
    ),
    home: const LoginScreen(),
  ));
}
