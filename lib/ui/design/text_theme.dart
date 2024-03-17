import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.overpass(
    // fontSize: 60,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -2,
  ),
  displayMedium: GoogleFonts.overpass(
    // fontSize: 34,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -1,
  ),
  displaySmall: GoogleFonts.overpass(
    // fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 1.45,
    letterSpacing: -1,
  ),
  headlineMedium: GoogleFonts.overpass(
    // fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -1,
  ),
  headlineSmall: GoogleFonts.overpass(
    // fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: -1,
  ),
  titleLarge: GoogleFonts.overpass(
    // fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    letterSpacing: -1,
  ),
  bodyLarge: GoogleFonts.overpass(
      // fontSize: 17,
      // fontWeight: FontWeight.normal,
      // letterSpacing: -1,
      ),
  bodyMedium: GoogleFonts.overpass(
      // fontSize: 12,
      // fontWeight: FontWeight.normal,
      // height: 1.5,
      // letterSpacing: -1,
      ),
  bodySmall: GoogleFonts.overpass(
      // fontSize: 14,
      // fontWeight: FontWeight.bold,
      // height: 1.3,
      // letterSpacing: 1,
      ),
  labelLarge: GoogleFonts.overpass(
    color: VanillaColorScheme.error,
  ),
);
