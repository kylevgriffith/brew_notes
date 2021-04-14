// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

List<Recipe> recipeFromJson(String str) =>
    List<Recipe>.from(json.decode(str).map((x) => Recipe.fromJson(x)));

String recipeToJson(List<Recipe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipe {
  Recipe({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.attempts,
  });

  int id;
  int type;
  String name;
  String description;
  List<String> ingredients;
  List<Attempt> attempts;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        description: json["description"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        attempts: List<Attempt>.from(
            json["attempts"].map((x) => Attempt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "description": description,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "attempts": List<dynamic>.from(attempts.map((x) => x.toJson())),
      };
}

class Attempt {
  Attempt({
    required this.startDate,
    this.endDate,
    this.originalGrav,
    this.finalGrav,
    required this.temperatures,
    required this.notes,
  });

  String startDate;
  String? endDate;
  double? originalGrav;
  double? finalGrav;
  List<Temperature> temperatures;
  List<Note> notes;

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        startDate: json["start_date"],
        endDate: json["end_date"],
        originalGrav: json["original_grav"].toDouble(),
        finalGrav: json["final_grav"],
        temperatures: List<Temperature>.from(
            json["temperatures"].map((x) => Temperature.fromJson(x))),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "original_grav": originalGrav,
        "final_grav": finalGrav,
        "temperatures": List<dynamic>.from(temperatures.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
      };
}

class Note {
  Note({
    required this.noteDate,
    required this.note,
  });

  String noteDate;
  String note;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteDate: json["note_date"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "note_date": noteDate,
        "note": note,
      };
}

class Temperature {
  Temperature({
    required this.tempTime,
    required this.value,
  });

  String tempTime;
  int value;

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        tempTime: json["temp_time"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "temp_time": tempTime,
        "value": value,
      };
}
