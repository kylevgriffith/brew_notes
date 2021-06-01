import 'package:brew_notes/main.dart';
import 'package:brew_notes/models/models.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final recipeFormController1 = TextEditingController();
  final recipeFormController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _radioValue1 = 0;

  // late FocusNode myFocus;

  @override
  void initState() {
    super.initState();

    // Start listening for changes
    recipeFormController1.addListener(_printLatestValue);
    recipeFormController2.addListener(() {
      print('${recipeFormController2.text}');
    });

    // init focus node
    // myFocus = FocusNode();
  }

  // clean-up controller when the widget is removed from the widget tree.
  void dispose() {
    recipeFormController1.dispose();
    recipeFormController2.dispose();
    super.dispose();
  }

  // fn to print latest value
  _printLatestValue() {
    print("Recipe Name: ${recipeFormController1.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: recipeFormController1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name your Recipe'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please name your recipe';
                }
                return null;
              },
            ),
            TextFormField(
              controller: recipeFormController2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Describe your Recipe'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please describe your recipe';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _radioValue1,
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value!;
                    });
                  },
                ),
                Text('${MyApp.recipeTypes[0]}'),
                Radio<int>(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value!;
                    });
                  },
                ),
                Text('${MyApp.recipeTypes[1]}'),
                Radio<int>(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value!;
                    });
                  },
                ),
                Text('${MyApp.recipeTypes[2]}'),
                Radio<int>(
                  value: 3,
                  groupValue: _radioValue1,
                  onChanged: (value) {
                    setState(() {
                      _radioValue1 = value!;
                    });
                  },
                ),
                Text('${MyApp.recipeTypes[3]}'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, [
                    _radioValue1,
                    recipeFormController1.text,
                    recipeFormController2.text
                  ]);
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
