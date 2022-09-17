// ignore_for_file: prefer_const_constructors

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quizzer_ui/mainstate.dart';
import 'package:quizzer_ui/model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class Quizzer extends StatefulWidget {
  const Quizzer({
    Key? key,
  }) : super(key: key);

  @override
  State<Quizzer> createState() => _QuizzerState();
}

class _QuizzerState extends State<Quizzer> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          child: FittedBox(child: Text("Quizzer")),
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
              child: QuizContainer(),
            ),
          ),
        ),
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

class QuizContainer extends StatefulWidget {
  const QuizContainer({Key? key}) : super(key: key);

  @override
  State<QuizContainer> createState() => _QuizContainerState();
}

class _QuizContainerState extends State<QuizContainer> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
            itemCount: mainState.players.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16, top: 4, bottom: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        for (var i = 0; i < mainState.players.length; i++) {
                          if (i == index) {
                            rightAnswer(i);
                          }
                        }
                      },
                      icon: Icon(Icons.check),
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () {
                        for (var i = 0; i < mainState.players.length; i++) {
                          if (i != index) {
                            wrongAnswer(i);
                          }
                        }
                      },
                      icon: Icon(Icons.error),
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    const Icon(Icons.person),
                    SizedBox(
                      width: 8,
                    ),
                    Text("(${mainState.players[index].points})   ${mainState.players[index].name}"),
                    Spacer(),
                  ],
                ),
              );
            });
      },
    );
  }

  void wrongAnswer(int i) {
    return setState(() {
      mainState.players[i].points = mainState.players[i].points + 1;
    });
  }

  void rightAnswer(int i) {
    return setState(() {
      mainState.players[i].points = mainState.players[i].points + 4;
    });
  }
}
