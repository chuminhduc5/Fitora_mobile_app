import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // static ThemeData data(bool isDark) {
  //   return ThemeData(
  //     brightness: isDark ? Brightness.dark : Brightness.light,
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: isDark ? AppColor.navy : AppColor.purple,
  //       centerTitle: true,
  //       elevation: 2.h,
  //       titleTextStyle: AppFont.bold.s16,
  //     ),
  //     floatingActionButtonTheme: FloatingActionButtonThemeData(
  //       backgroundColor: isDark ? AppColor.blue : AppColor.lightPurple,
  //       foregroundColor: isDark ? Colors.white : Colors.black,
  //       elevation: 2.h,
  //       extendedTextStyle: AppFont.normal.s14,
  //     ),
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: isDark ? AppColor.blue : AppColor.lightPurple,
  //         elevation: 2.h,
  //         textStyle: AppFont.normal.s14,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(6.r),
  //         ),
  //       ),
  //     ),
  //     visualDensity: VisualDensity.adaptivePlatformDensity,
  //     fontFamily: GoogleFonts.poppins().fontFamily,
  //     textTheme: TextTheme(
  //       bodySmall: AppFont.normal.s12,
  //       bodyMedium: AppFont.normal.s14,
  //       bodyLarge: AppFont.normal.s16,
  //     ),
  //   );
  // }

  static final darkMode = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.background,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff2C2B2B),
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
  );

  static final lightMode = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgWhite,
    brightness: Brightness.light,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.bgColor,
      contentTextStyle: const TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: const TextStyle(
        color: Color(0xff7A7A7A),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColors.primary.withOpacity(0.5),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
  );
}
