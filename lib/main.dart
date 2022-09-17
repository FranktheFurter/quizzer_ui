// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:quizzer_ui/quizzer.dart';
import 'package:quizzer_ui/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //hide debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
        primarySwatch: Colors.red,
        accentColor: Colors.red[500],
        toggleableActiveColor: Colors.red[500],
      ),
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Quizzer(),
                  Settings(),
                ],
              ),
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _tabController.animateTo(index);
            setState(() {});
          },
          currentIndex: _tabController.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.animation),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
