// === Not Currently in Use ===
// class to support use of provider with this project.

import 'package:flutter/material.dart';
import 'models.dart';

class RecipeCollectionModel extends ChangeNotifier {
  // the list of recipes
  final _recipes = <Recipe>[];

  // each Recipe contains its ingredients and Attempts.
  // Attempts contains measurments if they were taken, Temperatures, and Notes
  // on exit, or on change, the recipes need to be saved to a file, so _recipes
  // needs to be able to connect w/ changes made within a Recipe, but might not
  // need to "know" what they are, just be able to hand them to the save file.

  List<Recipe> get recipes => _recipes;

  void add(Recipe newRecipe) {
    _recipes.add(newRecipe);
    notifyListeners();
  }

  void remove(Recipe recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }

  void addIngredient(String newIngredient) {}
  void editIngredient() {}
  void addAttempt(Attempt newAttempt) {}
  void addTemp(Temperature newTemperature) {}
  void addNote() {}
}
