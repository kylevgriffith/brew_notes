// Ingredients are a custom data type convienetly store
// info about what gets put into a brew.
// Should be able to edit amount and unit after init.
class Ingredient {
  final String name;
  num amount;
  String unit;

  Ingredient(this.name, this.amount, this.unit);

  @override
  String toString() => "$name $amount $unit";
}
