import 'package:flutter/material.dart';
import '../models/models.dart';
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
                        // color: Colors.redAccent,
                        onPressed: () {})
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
                        // color: Colors.redAccent,
                        onPressed: () {})
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
}



 
      
      


// ingredient card
          // String ingredientStr = '';
          // (widget.recipe.ingredients).forEach((element) {
          //   ingredientStr += (element + '\n');
          // });
 
 
          // child: Column(
          // children: [
          //   Card(
          //     child: Column(
          //       children: [
          //         Text('Ingredients:',
          //             style:
          //                 TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          //         Text(ingredientStr)
          //       ],
          //     ),
          //   ),
          // ],
          // )
        