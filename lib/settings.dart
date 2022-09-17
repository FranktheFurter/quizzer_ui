// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_mobx/flutter_mobx.dart';
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
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            onChanged: (value) => mainState.word = value,
                            controller: fieldText,
                            decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(),
                            ),
                          )),
                          SizedBox(width: 32),
                          ElevatedButton.icon(
                              onPressed: () {
                                mainState.players.add(Player(name: mainState.word, points: 0));

                                setState(() {
                                  mainState.number = 0;
                                  mainState.word = "";
                                  fieldText.clear();
                                });
                              },
                              icon: Icon(Icons.add),
                              label: Text("Add")),
                          SizedBox(width: 32),
                          ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  for (var i = 0; i < mainState.players.length; i++) {
                                    mainState.players[i].points = 0;
                                  }
                                });
                              },
                              icon: Icon(Icons.add),
                              label: Text("Reset")),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        );
      },
    );
  }

  Widget SettingsContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: mainState.players.length,
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
              mainState.players.removeAt(index);
              setState(() {});
            },
            icon: Icon(Icons.delete),
            label: Text("Delete")),
        SizedBox(width: 32),
        Center(child: Text(mainState.players[index].name + "   " + mainState.players[index].points.toString(), style: TextStyle(fontSize: 24, color: Colors.white))),
      ]),
    );
  }
}
