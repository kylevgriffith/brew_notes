// import 'package:brew_notes/services/FileStorage.dart';
import 'package:brew_notes/services/FileStorage.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // allowed types of drinks
  static List<String> recipeTypes = ['Beer', 'Cider', 'Mead', 'Wine'];

  // make file i/o object
  // final localStorage = FileStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(storage: localStorage),
      home: HomePage(
        storage: FileStorage(),
      ),
    );
  }
}
