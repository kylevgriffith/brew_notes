import 'Ingredient.dart';
import 'Attempt.dart';

// Recipes are highest level representation of a brew.
// Contains a list of Ingredients that can be edited and added to as user finds
// their preferences. Should reflect most recent changes.
// Contains a list of Attempts for each time a user tries the recipe.
// Should be able to be deleted (which also deletes Ingredient & Attempt record)

// Home page should be list of recipes tiles (name, Category).
// Should organize by most recent attempt date.
// Should have a current list at the top (end not set b/c still happening).

class Recipe {
  String name;

  var ingredients = <Ingredient>[];
  var attempts = <Attempt>[];

  Recipe(this.name) {
    this.ingredients = setIngredients();
  }

  List<Ingredient> setIngredients() {
    return [
      Ingredient('water', 1, 'gallon'),
      Ingredient('yeast', 1.5, 'grams'),
      Ingredient('hops', 25, 'grams')
    ];
  }

  void _addIngredient(String name, num amount, String unit) =>
      {this.ingredients.add(Ingredient(name, amount, unit))};

  void _addAttempt() {}
}
