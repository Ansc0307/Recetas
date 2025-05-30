import 'package:flutter/material.dart';
import 'circlenode.dart';
import 'custom_shapes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool flagVueltas = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedRotation(
              turns: flagVueltas ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: flagVueltas ? 350 : 0,
                height: flagVueltas ? 350 : 0,
                child: Stack(
                  children: const [
                    

                    CircleNode(label: 'A', color: Colors.redAccent, alignment: Alignment(0, -1), shape: NodeShape.circle),
CircleNode(label: 'B', color: Colors.orange, alignment: Alignment(-1, 0), shape: NodeShape.triangle),
CircleNode(label: 'C', color: Colors.yellow, alignment: Alignment(0, 1), shape: NodeShape.diamond),
CircleNode(label: 'D', color: Colors.green, alignment: Alignment(1, 0), shape: NodeShape.hexagon),

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
        child: const Icon(Icons.sync),
      ),
    );
  }
}
