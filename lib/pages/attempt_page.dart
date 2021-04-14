import 'package:flutter/material.dart';
import '../models/models.dart';
// how to record datetime automatically?

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
                      "Temperatures:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        // color: Colors.limeAccent,
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
                          title: Text(widget
                                  .attempt.temperatures[index].tempTime +
                              ' ' +
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
                  itemCount: widget.attempt.notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.attempt.notes[index].noteDate +
                          ' ' +
                          widget.attempt.notes[index].note),
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
