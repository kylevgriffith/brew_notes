import 'package:brew_notes/main.dart';
import 'package:brew_notes/pages/recipe_page.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/Services.dart';

String bigObjJson = """
[
  {
    "id": 1,
    "type": 0, 
    "name": "Pallet Jack", 
    "description": "Brown Ale",
    "ingredients": [
        "1 gal water",
        "0.5 kg hops",
        "0.75 kg wheat",
        "t",
        "h",
        "i",
        "s",
        "w",
        "i",
        "l",
        "l",
        "b",
        "e",
        "t",
        "o",
        "o",
        "l",
        "o",
        "n",
        "g"
    ],
    "attempts": [
      {
        "start_date": "4/1/21", 
        "end_date": null, 
        "original_grav": 1.050,
        "final_grav": null,
        "temperatures": 
        [
          {"temp_time": "4/2/21", "value": 60},
          {"temp_time": "4/3/21", "value": 61},
          {"temp_time": "4/7/21", "value": 59}
        ],
        "notes": 
        [
	      {"note_date": "4/1/21", "note": "First day brewing"},
          {"note_date": "4/4/21", "note": "Some sediment has formed at the bottom. It's not bubbling as much as yesterday. Something smells like shit."},
          {"note_date": "4/6/21", "note": "Oh god, why?"}
	    ]
      }
    ]
  }
]
""";

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> _recipes = recipeFromJson(bigObjJson);
  bool _loading = false;

  // again, for if recipe storage moves to online
  // (TODO: look up state initialization in flutter2)
  // @override
  // void initState() {
  //   super.initState();
  //   _loading = true;
  //   _recipes = Services.getRecipes().then((recipes) {
  //     setState(() {
  //       _recipes = recipes;
  //       _loading = false;
  //     });
  //   }) as List<Recipe>;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Brew Notes'),
      ),
      body: Container(
        color: Colors.white,
        child: Scrollbar(
          child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = _recipes[index];
                return ListTile(
                  title: Text(recipe.name +
                      ' (' +
                      MyApp.recipeTypes[recipe.type] +
                      ')'),
                  subtitle: Text(recipe.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipePage(recipe)),
                    );
                  },
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // add recipes
        child: const Icon(Icons.add),
        backgroundColor: Colors.lime,
      ),
    );
  }
}
