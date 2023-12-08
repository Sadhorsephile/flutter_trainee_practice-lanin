import 'package:flutter/material.dart';
import 'package:flutter_notes/features/notes_list/notes_list.dart';
import 'package:flutter_notes/util/app_dictionary.dart';

/// Class for material app.
class NotesApp extends StatelessWidget {
  /// @nodoc
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppDictionary.appName,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 16, 46, 59),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF13B9FF),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 117, 208, 247),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF13B9FF),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const NotesListScreen(),
    );
  }
}
