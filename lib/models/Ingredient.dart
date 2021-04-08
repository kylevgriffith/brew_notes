// Ingredients are a custom data type convienetly store
// info about what gets put into a brew.
// Should be able to edit amount and unit after init.

class Ingredient {
  final String name;
  num amount;
  String unit;

  Ingredient(this.name, this.amount, this.unit);
  Ingredient.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        amount = json['amount'],
        unit = json['unit'];

  Map<String, dynamic> toJson() =>
      {"name": name, "amount": amount, "unit": unit};

  @override
  String toString() => "$name $amount $unit";
}
