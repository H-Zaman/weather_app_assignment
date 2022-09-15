import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/root_bindings.dart';
import 'package:weather/src/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Weather App',
    initialBinding: RootBindings(),
    theme: ThemeData(
      textTheme: GoogleFonts.adventProTextTheme()
    ),
    home: HomeScreen(),
  );
}