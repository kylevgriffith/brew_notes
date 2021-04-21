import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNoteForm extends StatefulWidget {
  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final noteFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Start listening for changes
    noteFormController.addListener(_printLatestValue);
  }

  // clean-up controller when the widget is removed from the widget tree.
  void dispose() {
    noteFormController.dispose();
    super.dispose();
  }

  // fn to print latest value
  _printLatestValue() {
    print("Note field: ${noteFormController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: noteFormController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Write your note'),
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
                  String now = DateFormat.yMd('en_US').format(DateTime.now());
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text(now + ' ' + noteFormController.text)));
                  Navigator.pop(
                      context, <String>[now, noteFormController.text]);
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
