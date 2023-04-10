// Importing the required packages and files
import 'package:flutter/material.dart';
import 'screens/adduser_screen.dart';

// main function is the entry point of the app
void main() {
  runApp(const MyApp());
}

//  Define a new StatelessWidget named MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // The build method returns the overall widget tree for the screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // hides the debug banner on the top right corner of the screen
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white38),
      ),
      // initial screen of the app when it launches.
      home: AddUserScreen(),
    );
  }
}
