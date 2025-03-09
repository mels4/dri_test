import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meli_driweather/theme/color.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.overpass().fontFamily,
        textTheme: GoogleFonts.overpassTextTheme().copyWith(
          headlineLarge: TextStyle(
            fontSize: 40,
            color: black1Color,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(fontSize: 24, color: black1Color),
          titleSmall: TextStyle(fontSize: 18, color: blue5Color),
          bodyLarge: TextStyle(fontSize: 16, color: black1Color),
        ),
      ),
    ),
  );
}
