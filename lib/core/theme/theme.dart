import 'package:fithub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
    primaryColor: Colors.lightBlue[800],
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Manrope',
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Manrope',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        color: greyColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Manrope',
      ),
      titleLarge: TextStyle(
        fontSize: 36,
        color: greyColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Manrope',
      ),
      titleSmall: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.w900,
        fontFamily: 'Manrope',
      ),
      bodyMedium: TextStyle(fontFamily: 'Inter'),
      titleMedium: TextStyle(fontFamily: 'Inter'),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: greyColor,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      dialHandColor: primaryColor,
      dayPeriodColor: lightPrimaryColor.withOpacity(0.1),
      hourMinuteColor: lightPrimaryColor.withOpacity(0.1),
      dialBackgroundColor: lightPrimaryColor.withOpacity(0.2),
      dayPeriodTextStyle: const TextStyle(fontFamily: 'Inter'),
      dialTextStyle: const TextStyle(fontFamily: 'Inter'),
      helpTextStyle: const TextStyle(fontFamily: 'Inter'),
      cancelButtonStyle: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith(
          (states) => const TextStyle(
            fontFamily: 'Inter',
            color: primaryColor,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith(
          (states) => const TextStyle(
            fontFamily: 'Inter',
            color: primaryColor,
          ),
        ),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => primaryColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: lightGreyColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: lightPrimaryColor,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        hintStyle: const TextStyle(fontFamily: 'Inter'),
        outlineBorder: const BorderSide(
          color: lightGreyColor,
          width: 1.5,
        )));
