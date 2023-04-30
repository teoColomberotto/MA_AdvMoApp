import 'package:flutter/material.dart';
import 'package:quiz_app/constants/colors.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Pokemon',

    //AppBar
    appBarTheme: AppBarTheme(
      color: MyColors.myWhite,
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColors.myWhite,
      ),
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: MyColors.myWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleMedium: TextStyle(
          color: MyColors.myWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ).titleLarge,
    ),

    //Button
    buttonTheme: ButtonThemeData(
      buttonColor: MyColors.mySecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyColors.myBlack,
    ),

    //Text
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w700,
        color: MyColors.myBlack,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w700,
        color: MyColors.myBlack,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w500,
        color: MyColors.myBlack,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w700,
        color: MyColors.myBlack,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w700,
        color: MyColors.myBlack,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w500,
        color: MyColors.myBlack,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        letterSpacing: 0.15,
        fontWeight: FontWeight.w400,
        color: MyColors.myBlack,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w400,
        color: MyColors.myBlack,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w400,
        color: MyColors.myBlack,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w200,
        color: MyColors.myBlack,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        letterSpacing: 0.15,
        fontWeight: FontWeight.w500,
        color: MyColors.myBlack,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w700,
        color: MyColors.myBlack,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w500,
        color: MyColors.myWhite,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
        color: MyColors.myWhite,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500,
        color: MyColors.myWhite,
      ),
    ),

    //Snackbar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      elevation: 20,
      showCloseIcon: false,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: MyColors.mySecondaryColor,
      contentTextStyle: TextStyle(
        color: MyColors.myOnSecondaryColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),

    //ProgressIndicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearMinHeight: 20,
      color: Colors.transparent,
      circularTrackColor: MyColors.mySecondaryColor,
    ),

    //Card
    cardTheme: CardTheme(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: MyColors.mySurfaceColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    //Text field
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      filled: true,
      fillColor: MyColors.myTertiaryColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.myTertiaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.myTertiaryColor,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      labelStyle: TextStyle(
        color: MyColors.myBlack,
      ),
      hintStyle: TextStyle(
        color: MyColors.myTertiaryColor,
      ),
      errorStyle: TextStyle(
        color: MyColors.myErrorColor,
      ),
    ),

    //Color
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      background: MyColors.myBackgroundColor,
      onBackground: MyColors.myOnBackgroundColor,
      error: MyColors.myErrorColor,
      onError: MyColors.myOnErrorColor,
      primary: MyColors.myPrimaryColor,
      onPrimary: MyColors.myOnPrimaryColor,
      secondary: MyColors.mySecondaryColor,
      onSecondary: MyColors.myOnSecondaryColor,
      tertiary: MyColors.myTertiaryColor,
      onTertiary: MyColors.myOnTertiaryColor,
      surface: MyColors.mySurfaceColor,
      onSurface: MyColors.myOnSurfaceColor,
    ),
  );

  // static final ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   fontFamily: 'Roboto',
  //   appBarTheme: AppBarTheme(
  //     color: Colors.black,
  //     elevation: 0,
  //     iconTheme: const IconThemeData(
  //       color: Colors.white,
  //     ),
  //     toolbarTextStyle: const TextTheme(
  //       titleLarge: TextStyle(
  //         color: Colors.white,
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ).bodyMedium,
  //     titleTextStyle: const TextTheme(
  //       titleMedium: TextStyle(
  //         color: Colors.white,
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ).titleLarge,
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.grey,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //   ),
  //   textTheme: const TextTheme(
  //     bodyLarge: TextStyle(fontSize: 16),
  //     bodyMedium: TextStyle(fontSize: 14),
  //   ),
  //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
  //       .copyWith(secondary: Colors.amber),
  // );
}
