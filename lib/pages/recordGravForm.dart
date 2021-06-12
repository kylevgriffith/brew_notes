import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RecordGravForm extends StatefulWidget {
  const RecordGravForm({Key? key}) : super(key: key);

  @override
  _RecordGravFormState createState() => _RecordGravFormState();
}

class _RecordGravFormState extends State<RecordGravForm> {
  final gravFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Start listening for changes
    gravFormController.addListener(_printLatestValue);
  }

  // clean-up controller when the widget is removed from the widget tree.
  void dispose() {
    gravFormController.dispose();
    super.dispose();
  }

  // fn to print latest value
  _printLatestValue() {
    print("specific gravity field: ${gravFormController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a Specific Gravity'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: gravFormController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d?\.?\d{0,3}"))
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'Record measured specific gravity here (ex: 1.050)'),
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
                  double grav = double.parse(gravFormController.text);
                  Navigator.pop(context, [now, grav]);
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
