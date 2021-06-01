import 'package:brew_notes/main.dart';
import 'package:brew_notes/pages/recipe_page.dart';
import 'package:brew_notes/services/FileStorage.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'addRecipe.dart';

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
        "start_date": "4/1/2021", 
        "end_date": null, 
        "original_grav": 1.050,
        "final_grav": null,
        "temperatures": 
        [
          {"temp_time": "4/2/2021", "value": 60},
          {"temp_time": "4/3/2021", "value": 61},
          {"temp_time": "4/7/2021", "value": 59}
        ],
        "notes": 
        [
	      {"note_date": "4/1/2021", "note": "First day brewing"},
          {"note_date": "4/4/2021", "note": "Some sediment has formed at the bottom. It's not bubbling as much as yesterday. Something smells."},
          {"note_date": "4/6/2021", "note": "Oh god, why?"}
	    ]
      }
    ]
  }
]
""";

class HomePage extends StatefulWidget {
  final FileStorage storage;

  HomePage({required this.storage}) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // _recipes = recipeFromJson(read);
    widget.storage.loadData().then((List<Recipe> savedRecipes) => {
          // setState(() {
          //   _recipes = savedRecipes;
          //   _loading = false;
          // })
          print(recipeToJson(savedRecipes)),

          if (savedRecipes.isNotEmpty)
            {
              setState(() {
                _recipes = savedRecipes;
                _loading = false;
              }),
              print("loaded from file!!!")
            }
          else
            {
              // if save file is not found
              setState(() {
                _recipes = recipeFromJson(bigObjJson);
                _loading = false;
              })
            }
        });
    // setState(() {
    //   _recipes = recipeFromJson(bigObjJson);
    //   _loading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            appBar: AppBar(
              title: Text('Loading..'),
            ),
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Brew Notes'),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: Icon(Icons.save),
                    iconSize: 26.0,
                    onPressed: () {
                      _saveChanges(widget.storage, _recipes);
                      print(
                          '${_recipes[0].attempts[0].temperatures.last.value}');
                    },
                  ),
                )
              ],
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
                        // go to recipe details
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipePage(recipe)),
                          );
                        },
                        // remove recipe
                        onLongPress: () {
                          setState(() {
                            _recipes.remove(recipe);
                          });
                        },
                      );
                    }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addRecipe();
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.lime,
            ),
          );
  }

  // add new recipe, flexible form to account for multiple ingredients?

  // Expected a value of type '(() => void)?', but got one of type '_Future<dynamic>'
  _addRecipe() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddRecipeForm()));
    if (result is List) {
      if (result[0] is int && result[1] is String && result[2] is String) {
        // construct basic
        final newRecipe = Recipe(
            // TODO: find better way to make recipe ids.
            id: _recipes.last.id + 1,
            type: result[0],
            name: result[1],
            description: result[2],
            ingredients: [],
            attempts: []);
        setState(() {
          _recipes.add(newRecipe);
        });
      }
    }
  }

  _saveChanges(FileStorage storage, List<Recipe> data) {
    print('Trying to save data');
    print(recipeToJson(data));
    return storage.writeData(data);
  }
}
