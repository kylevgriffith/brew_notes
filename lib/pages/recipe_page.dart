import 'package:flutter/material.dart';
import 'attempt_page.dart';

class RecipePage extends StatefulWidget {
  final String recipe;

  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.recipe}'),
      ),
      body: Center(
        child: Text('Recipe for ${widget.recipe}'),
      ),
    );
  }
}
