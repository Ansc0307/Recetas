import 'dart:math';

import 'package:flutter/material.dart';
import 'Vista/bmi_screen.dart';
import 'ModelRT/obesity_predictor_form.dart';
import 'home_page.dart';
import 'analysis_history_page.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool flagVueltas = false;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: AnimatedRotation(
              turns: flagVueltas ? 1 : 0,
              duration: Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                width: flagVueltas ? 350 : 0,
                height: flagVueltas ? 350 : 0,
                //color: Colors.purple,
                child: Stack(
                  children: [
                    nodo(Colors.redAccent, 'A', 0, -1),
                    nodo(Colors.orange, 'B', -1, 0),
                    nodo(Colors.yellow, 'C', 0, 1),
                    nodo(Colors.green, 'D', 1, 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            flagVueltas = !flagVueltas;
          });
        },
      ),
    );
  }

  Widget nodo(color, msg, double x1, double y1) {
    return Align(
      alignment: Alignment(x1, y1),
      child: GestureDetector(
        onTap: () {
          setState(() {
            switch (msg) {
              case 'A':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ObesityPredictorForm()),
                );

                break;
              case 'B':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BmiScreen()),
                );
                break;
              case 'C':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 'D':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalysisHistoryPage()),
                );
                break;
            }
          });
        },
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: RadialGradient(colors: [Colors.white, color]),
          ),
          child: Center(child: Text(msg, style: TextStyle(fontSize: 45))),
        ),
      ),
    );
  }
}