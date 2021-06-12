import 'package:brew_notes/pages/recordGravForm.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'addEditIngredient.dart';
import 'attempt_page.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  RecipePage(this.recipe) : super();

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.name),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      "Ingredients:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _addIngredient();
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                color: Colors.limeAccent,
              ),
              Flexible(
                child: Scrollbar(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.recipe.ingredients[index]),
                          onTap: () {
                            _editIngredient(
                                widget.recipe.ingredients[index], index);
                          },
                          onLongPress: () {
                            setState(() {
                              widget.recipe.ingredients.removeAt(index);
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: widget.recipe.ingredients.length),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Attempts:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _newAttempt();
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                color: Colors.redAccent,
              ),
              Flexible(
                  child: Scrollbar(
                child: ListView.separated(
                  itemCount: widget.recipe.attempts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.recipe.attempts[index].startDate +
                          (widget.recipe.attempts[index].endDate != null
                              ? (' - ' + widget.recipe.attempts[index].endDate!)
                              : '')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttemptPage(
                                    widget.recipe.name,
                                    widget.recipe.attempts[index])));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ))
            ],
          ),
        ));
  }

  // only use on existing ingredient list tiles
  _editIngredient(String current, int index) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddIngredientForm(currentIngredient: current)));
    if (result is String) {
      setState(() {
        widget.recipe.ingredients[index] = result;
      });
    }
  }

  // add new ingredient to list.
  _addIngredient() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddIngredientForm()));
    if (result is String) {
      setState(() {
        widget.recipe.ingredients.add(result);
      });
    }
  }

  // create a new attempt after prompting user to measure initial specific gravity.
  _newAttempt() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecordGravForm()));
    if (result is List) {
      setState(() {
        widget.recipe.attempts.add(Attempt(
            startDate: result[0],
            originalGrav: result[1],
            temperatures: <Temperature>[],
            notes: <Note>[]));
      });
    }
  }
}
