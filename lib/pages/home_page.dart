import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'recipe_page.dart';

// class RecipeStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationSupportDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/recipes.txt');
//   }

//   Future<String> readRecipes() async {
//     try {
//       final file = await _localFile;
//       // read the file
//       String contents = await file.readAsString();

//       // TODO: how to return/build list of recipes?
//       return contents;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<File> writeRecipes(String recipes) async {
//     final file = await _localFile;

//     // write the file
//     return file.writeAsString('$recipes');
//   }
// }

// enum RecipieTypes { Beer, Cider, Mead, Wine }
List<String> recipeTypes = ['Beer', 'Cider', 'Mead', 'Wine'];

String retrievedJson = """
  [
    {"type": 0, "name": "Pallet Jack", "description": "Brown Ale"},
    {"type": 1, "name": "Grapefruit & Chill", "description": "Grapefruit Cider"},
    {"type": 1, "name": "Bad Apple", "description": "Imperial Cider"},
    {"type": 2, "name": "Short Mead", "description": "Just Mead"},
    {"type": 2, "name": "Viking's Blood", "description": "Cherry Mead"},
    {"type": 2, "name": "Strawberry Pepper", "description": "Weird Mead"},
    {"type": 3, "name": "Prison Hooch", "description": "Sangria fr'm th' Terlit"}
  ]
  """;
String bigObjJSON = """
  [
    {
      "type": 0, 
      "name": "Pallet Jack", 
      "description": "Brown Ale",
      "ingredients": [
        {"name": "water", "amount": 1.0, "unit": "gallon"},
        {"name": "hops", "amount": 0.5, "unit": "kg"},
        {"name": "wheat", "amount": 0.75, "unit": "kg"}
      ],
      "attempts": [
        {
          "start_date": "4/1/21", 
          "end_date": null, 
          "original_grav": 1.050,
          "final_grav": null,
          "temperatures": 
          [
            {"temp_time": "4/2/21", "value": 20, "unit": "C"},
            {"temp_time": "4/3/21", "value": 21, "unit": "C"},
            {"temp_time": "4/7/21", "value": 19, "unit": "C"}
          ],
          "notes": 
          [
            {"note_date": "4/4/21", "note": "Some sediment has formed at the bottom. It's not bubbling as much as yesterday. Something smells like shit."}
          ]
        }
      ]
    }
  ]
  """;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  // final List<RecipieTypes> rTypes = RecipieTypes.values;
  final List<String> rTypes = recipeTypes;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _recipes = jsonDecode(retrievedJson);

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // child: Column(
        //   // Column is also a layout widget. It takes a list of children and
        //   // arranges them vertically. By default, it sizes itself to fit its
        //   // children horizontally, and tries to be as tall as its parent.
        //   //
        //   // Invoke "debug painting" (press "p" in the console, choose the
        //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
        //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        //   // to see the wireframe for each widget.
        //   //
        //   // Column has various properties to control how it sizes itself and
        //   // how it positions its children. Here we use mainAxisAlignment to
        //   // center the children vertically; the main axis here is the vertical
        //   // axis because Columns are vertical (the cross axis would be
        //   // horizontal).
        child: ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${_recipes[index]['name']} ' +
                      '(${widget.rTypes[_recipes[index]['type']]})',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${_recipes[index]['description']}'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipePage(recipe: "Me Secr't Formul'r!");
                }));
              },
            );
          },
        ),
      ),
    );
  }
}
