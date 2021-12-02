import 'package:brew_notes/services/FileStorage.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // allowed types of drinks
  static List<String> recipeTypes = ['Beer', 'Cider', 'Mead', 'Wine'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brew Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        storage: FileStorage(),
      ),
    );
  }
}
