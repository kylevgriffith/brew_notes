// possibly useful if I switch to having users store data online...

import 'package:http/http.dart' as http;
import '../models/models.dart';

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
