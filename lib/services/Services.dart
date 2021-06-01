// possibly useful if I switch to having users store data online...
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import '../models/models.dart';

// === add to home_page.dart if we move to online storage ===
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

class Services {
  static const String url = '';

  static Future<List<Recipe>> getRecipes() async {
    try {
      final response = await http.get(url as Uri);
      if (200 == response.statusCode) {
        final List<Recipe> recipes = recipeFromJson(response.body);
        return recipes;
      } else {
        return <Recipe>[];
      }
    } catch (e) {
      return <Recipe>[];
    }
  }
}

// === File I/O ===
class JsonStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recipes.json');
  }

  Future<String> readRecipes() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Something went wrong.';
    }
  }

  Future<File> writeRecipes(List<Recipe> recipes) async {
    final file = await _localFile;

    final String results = recipeToJson(recipes);

    // Write the file
    return file.writeAsString(results);
  }
}
