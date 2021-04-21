import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // Mocks
  // String retrievedJson = """
  //   [
  //     {"type": 0, "name": "Pallet Jack", "description": "Brown Ale"},
  //     {"type": 1, "name": "Grapefruit & Chill", "description": "Grapefruit Cider"},
  //     {"type": 1, "name": "Bad Apple", "description": "Imperial Cider"},
  //     {"type": 2, "name": "Short Mead", "description": "Just Mead"},
  //     {"type": 2, "name": "Viking's Blood", "description": "Cherry Mead"},
  //     {"type": 2, "name": "Strawberry Pepper", "description": "Weird Mead"},
  //     {"type": 3, "name": "Prison Hooch", "description": "Sangria fr'm th' Terlit"}
  //   ]
  //   """;

  // allowed types of drinks
  static List<String> recipeTypes = ['Beer', 'Cider', 'Mead', 'Wine'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
