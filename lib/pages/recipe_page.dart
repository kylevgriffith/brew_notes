import 'package:flutter/material.dart';
import '../models/models.dart';
import 'addEditIngredient.dart';
import 'attempt_page.dart';
import 'package:intl/intl.dart';

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
                        // color: Colors.redAccent,
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
                          setState(() {
                            widget.recipe.attempts.add(Attempt(
                                startDate: DateFormat.yMd('en_US')
                                    .format(DateTime.now()),
                                temperatures: <Temperature>[],
                                notes: <Note>[]));
                          });
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
                      title: Text(widget.recipe.attempts[index].startDate),
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
    // do i need to check if this is a list? or can I just get a string/ not a null?
    // if (result is List) {
    if (result is String) {
      setState(() {
        widget.recipe.ingredients[index] = result;
      });
    }
    // }
  }

  // add new ingredient to list.
  _addIngredient() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddIngredientForm()));
    // do i need to check if this is a list? or can I just get a string/ not a null?
    // if (result is List) {
    if (result is String) {
      setState(() {
        widget.recipe.ingredients.add(result);
      });
    }
    // }
  }
}

// TODO: Add new attempt, should just be named the date, (should I highlight ones that aren't done?)
