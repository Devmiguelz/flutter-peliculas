import 'package:flutter/material.dart';

class AppTheme {
	static const primaryColor = Colors.indigo;

	static ThemeData lightTheme = ThemeData.light().copyWith(
		// Color primario
		primaryColor: primaryColor,

		// AppBar theme
		appBarTheme: const AppBarTheme(color: primaryColor, elevation: 0),

		// TextButton theme
		textButtonTheme:
				TextButtonThemeData(style: TextButton.styleFrom(primary: primaryColor)),

		// FloatingActionButton theme
		floatingActionButtonTheme: const FloatingActionButtonThemeData(
			backgroundColor: primaryColor,
			elevation: 5,
		),

		elevatedButtonTheme: ElevatedButtonThemeData(
			style: ElevatedButton.styleFrom(
					primary: primaryColor,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(30.0),
					),
					elevation: 0),
		),

		// TextField theme
		inputDecorationTheme: InputDecorationTheme(
			floatingLabelStyle: const TextStyle(color: primaryColor),
			enabledBorder: OutlineInputBorder(
				borderSide: const BorderSide(color: primaryColor),
				borderRadius: BorderRadius.circular(5),
			),
			focusedBorder: OutlineInputBorder(
				borderSide: const BorderSide(color: primaryColor),
				borderRadius: BorderRadius.circular(5),
			),
			border: OutlineInputBorder(
				borderSide: const BorderSide(color: primaryColor),
				borderRadius: BorderRadius.circular(5),
			),
			iconColor: primaryColor,
			labelStyle: const TextStyle(color: Colors.black),
			hintStyle: const TextStyle(color: Colors.black),
		),

		// AlertDialog theme
		dialogTheme: DialogTheme(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(30),
			),
			elevation: 20,
		),
	);
	

	static ThemeData darkTheme = ThemeData.dark().copyWith(
		// Color primario
		primaryColor: Colors.indigo,

		// AppBar theme
		appBarTheme: const AppBarTheme(color: primaryColor, elevation: 0),
	);
}
