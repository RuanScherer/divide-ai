import 'package:divide_ai/firebase_options.dart';
import 'package:divide_ai/globals/globals.dart';
import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/screens/create_username_screen.dart';
import 'package:divide_ai/screens/home_screen.dart';
import 'package:divide_ai/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DivideAí',
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: const Color(0xFF00E4A7),
        accentColor: const Color(0xFF00E4A7),
        textTheme: GoogleFonts.nunitoTextTheme(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF00E4A7),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF00E4A7),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFF00E4A7),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => AuthenticationProvider(),
        child: Consumer<AuthenticationProvider>(
          builder: (context, authentication, child) {
            if (authentication.currentUser == null) return const LoginScreen();

            if (authentication.currentUser!.username == null) {
              return const CreateUsernameScreen();
            }

            return const HomeScreen();
          },
        ),
      ),
    ),
  );
}
