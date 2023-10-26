import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Color for the text for everything
  static Color textColor = Colors.black;

  // Color for listtiles & appbar
  static Color primaryColor = const Color.fromARGB(255, 142, 199, 201);

  // Backgroundcolor (The scaffold)
  static Color backgroundColor = Colors.white;

  // Color for all icons
  static Color iconColor = Colors.black;

  // Styling for buttons
  static Color textButtonColor = Colors.black;
  // static Color buttonColor = primaryColor;
  static Color buttonColor = const Color.fromARGB(255, 111, 167, 169);

  static ThemeData appStyling() {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
/*       colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 146, 121, 189)), */
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
        backgroundColor: buttonColor,
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
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
            color: textButtonColor, fontSize: 16, fontWeight: FontWeight.bold)),
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
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
