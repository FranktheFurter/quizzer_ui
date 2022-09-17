// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:quizzer_ui/mainstate.dart';
import 'package:quizzer_ui/model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          child: FittedBox(child: Text("Settings")),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SettingsContainer(),
            ),
          ),
        ),
        Container(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        mainState.number = int.parse(value);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  )),
                  SizedBox(width: 32),
                  Expanded(
                      child: TextField(
                    onChanged: (value) => mainState.word = value,
                    decoration: InputDecoration(
                      labelText: "Word",
                      border: OutlineInputBorder(),
                    ),
                  )),
                  SizedBox(width: 32),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (mainState.number == 0 || mainState.word.isEmpty) {
                          return;
                        }
                        mainState.matchesToDisplay.add(WordNumberMatch(
                          name: mainState.word,
                          number: mainState.number,
                        ));
                        mainState.number = 0;
                        mainState.word = "";
                        setState(() {});
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add")),
                ],
              ),
            ))
      ],
    );
  }

  Widget SettingsContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: mainState.matchesToDisplay.length,
        itemBuilder: (context, index) {
          return RowElement(index);
        },
      ),
    );
  }

  Widget RowElement(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        OutlinedButton.icon(
            onPressed: () {
              mainState.matches.removeAt(index);
              setState(() {});
            },
            icon: Icon(Icons.delete),
            label: Text("Delete")),
        SizedBox(width: 32),
        Text("${index + 1}:", style: TextStyle(fontSize: 24, color: Colors.white)),
        SizedBox(width: 16),
        Text(mainState.matches[index].number.toString(), style: TextStyle(fontSize: 24, color: Colors.white)),
        Icon(Icons.arrow_right, size: 24, color: Colors.white),
        Center(child: Text(mainState.matches[index].name, style: TextStyle(fontSize: 24, color: Colors.white))),
      ]),
    );
  }
}
