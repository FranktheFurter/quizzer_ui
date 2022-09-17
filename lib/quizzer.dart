// ignore_for_file: prefer_const_constructors

import 'package:quizzer_ui/mainstate.dart';
import 'package:quizzer_ui/model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class Fizzbuzz extends StatefulWidget {
  const Fizzbuzz({
    Key? key,
  }) : super(key: key);

  @override
  State<Fizzbuzz> createState() => _FizzbuzzState();
}

class _FizzbuzzState extends State<Fizzbuzz> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          child: FittedBox(child: Text("Fizzbuzz")),
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
              child: FizzContainer(_scrollController),
            ),
          ),
        ),
        Container(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text("Start"),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(seconds: 180),
                      curve: Curves.linear,
                    );
                  },
                ),
                ElevatedButton(
                  child: Text("Reset"),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.linear,
                    );
                  },
                )
              ],
            ))
      ],
    );
  }

  Widget FizzContainer(ScrollController ctrl) {
    ;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        controller: ctrl,
        itemCount: 999,
        itemBuilder: (context, index) {
          return RowElement(index + 1);
        },
      ),
    );
  }

  Row RowElement(int index) {
    String replacementText = "";
    bool matchFound = false;
    for (int i = 0; i < mainState.matches.length; i++) {
      if (index % mainState.matches[i].number == 0) {
        replacementText = "$replacementText${mainState.matches[i].name}";
        matchFound = true;
      }
    }
    return Row(children: [
      Expanded(
        child: Center(child: Text("$index", style: TextStyle(fontSize: 24, color: matchFound ? Colors.red : Colors.white))),
      ),
      Expanded(
          child: Center(
              child: Icon(
        Icons.arrow_right,
        size: 24,
        color: matchFound ? Colors.red : Colors.white,
      ))),
      Expanded(child: Center(child: Text(replacementText, style: TextStyle(fontSize: 24, color: matchFound ? Colors.red : Colors.white)))),
    ]);
  }
}
