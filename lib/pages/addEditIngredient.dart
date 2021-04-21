import 'package:flutter/material.dart';

class AddIngredientForm extends StatefulWidget {
  final String? currentIngredient;

  AddIngredientForm({this.currentIngredient}) : super();

  @override
  _AddIngredientFormState createState() => _AddIngredientFormState();
}

class _AddIngredientFormState extends State<AddIngredientForm> {
  final ingredientFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // set inititial text if editing an ingredient
    if (widget.currentIngredient != null) {
      ingredientFormController.text = widget.currentIngredient!;
    }

    // Start listening for changes
    ingredientFormController.addListener(_printLatestValue);
  }

  // clean-up controller when the widget is removed from the widget tree.
  void dispose() {
    ingredientFormController.dispose();
    super.dispose();
  }

  // fn to print latest value
  _printLatestValue() {
    print("ingredient field: ${ingredientFormController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ingredient'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: ingredientFormController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your ingredient and amount'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, ingredientFormController.text);
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
