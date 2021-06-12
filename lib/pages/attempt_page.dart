import 'package:brew_notes/pages/addTemp.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'addNote.dart';
import 'recordGravForm.dart';

class AttemptPage extends StatefulWidget {
  final String recipeName;
  final Attempt attempt;
  AttemptPage(this.recipeName, this.attempt) : super();

  @override
  _AttemptPageState createState() => _AttemptPageState();
}

class _AttemptPageState extends State<AttemptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.recipeName + " Attempt " + widget.attempt.startDate),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      "Stats:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          _getFinalGrav(context);
                        } catch (e) {
                          print('Returned w/o setting final grav');
                        }
                      },
                      child: Text(
                        "Record Final Gravity",
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 400,
                height: 200,
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Original Gravity: ' +
                            (widget.attempt.originalGrav != null
                                ? widget.attempt.originalGrav!
                                    .toStringAsFixed(3)
                                : '')),
                      ),
                      ListTile(
                        title: Text('Final Gravity: ' +
                            (widget.attempt.finalGrav != null
                                ? widget.attempt.finalGrav!.toStringAsFixed(3)
                                : '')),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Temperatures:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          try {
                            _getNewTemp(context);
                          } catch (e) {
                            print("Returned w/o making new Temp");
                          }
                        })
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
                          leading:
                              Text(widget.attempt.temperatures[index].tempTime),
                          title: Text(
                              '${widget.attempt.temperatures[index].value}'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: widget.attempt.temperatures.length),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Notes:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        try {
                          _getNewNote(context);
                        } catch (e) {
                          print('Returned w/o making new note');
                        }
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                color: Colors.redAccent,
              ),
              Flexible(
                  child: Scrollbar(
                child: ListView.separated(
                  itemCount: widget.attempt.notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(widget.attempt.notes[index].noteDate),
                      title: Text(widget.attempt.notes[index].note),
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

  _getNewTemp(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTempForm()));
    if (result is List) {
      if (result[0] is String && result[1] is int) {
        setState(() {
          widget.attempt.temperatures
              .add(Temperature(tempTime: result[0], value: result[1]));
        });
      }
    }
  }

  _getNewNote(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNoteForm()));
    if (result is List<String>) {
      setState(() {
        widget.attempt.notes.add(Note(noteDate: result[0], note: result[1]));
      });
    }
  }

  _getFinalGrav(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecordGravForm()));
    if (result is List) {
      setState(() {
        widget.attempt.endDate = result[0];
        widget.attempt.finalGrav = result[1];
      });
    }
  }
}
