import 'package:divide_ai/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DivideAí',
    theme: ThemeData(
      backgroundColor: Colors.white,
      primaryColor: const Color(0XFF44C994),
      textTheme: GoogleFonts.nunitoTextTheme(),
    ),
    home: const HomeScreen(),
  ));
}
