import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddTempForm extends StatefulWidget {
  @override
  _AddTempFormState createState() => _AddTempFormState();
}

class _AddTempFormState extends State<AddTempForm> {
  final tempFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Start listening for changes
    tempFormController.addListener(_printLatestValue);
  }

  // clean-up controller when the widget is removed from the widget tree.
  void dispose() {
    tempFormController.dispose();
    super.dispose();
  }

  // fn to print latest value
  _printLatestValue() {
    print("Temp field: ${tempFormController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Temperature'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: tempFormController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a temperature in Fahrenheit'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String now = DateFormat.yMd('en_US').format(DateTime.now());
                  int temp = int.parse(tempFormController.text);
                  Navigator.pop(context, [now, temp]);
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
