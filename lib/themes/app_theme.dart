import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Color for the text for everything
  static Color textColor = Colors.white;

  // Color for listtiles & appbar
  static Color primaryColor = Colors.black;

  // Backgroundcolor (The scaffold)
  static Color backgroundColor = const Color.fromARGB(108, 46, 42, 42);

  // Color for all icons
  static Color iconColor = Colors.pinkAccent;

  // Styling for buttons
  static Color textButtonColor = Colors.pink;
  static Color buttonColor = primaryColor;
  static Color buttonBackground = const Color.fromARGB(255, 35, 35, 36);

  static ThemeData appStyling() {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      fontFamily: GoogleFonts.openSans().fontFamily,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        // Color for the icon
        foregroundColor: iconColor,
        backgroundColor: buttonBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
      listTileTheme: ListTileThemeData(iconColor: iconColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(textButtonColor),
        textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: textButtonColor)),
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all<Color>(buttonBackground),
      )),
      iconTheme: IconThemeData(color: iconColor),
      textTheme: const TextTheme(

              // Global styling, use Theme... to use a specific style
              //and copyWith to overwrite specific values
              titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // Edit
              titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              titleSmall: TextStyle(),
              bodyLarge: TextStyle(),
              bodyMedium: TextStyle(),
              // Buttons uses labelLarge
              labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .apply(bodyColor: textColor, displayColor: textColor),
    );
  }
}
