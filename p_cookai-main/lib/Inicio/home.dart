import 'package:flutter/material.dart';
import 'Menu/circlenode.dart';
import 'Menu/custom_shapes.dart';
import 'Menu/plate_painter.dart';
import 'Menu/TableBackgroundPainter.dart';

class Home extends StatefulWidget {
  final bool esPremium;
  const Home({Key? key, required this.esPremium}) : super(key: key);

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
          // 🪵 Simulated Wood Table Background
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TableBackgroundPainter(),
          ),

          // 🔤 TÍTULO ANIMADO (Siempre arriba)
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: flagVueltas ? 0.0 : 1.0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 600),
                offset: flagVueltas ? const Offset(0, -0.2) : Offset.zero,
                
                  
                  
child: ShaderMask(
  shaderCallback: (bounds) => LinearGradient(
    colors: [
      Colors.blue,
      Colors.blue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
  child: Text(
    'F.O.O.D.I.E',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      shadows: [
        Shadow(
          offset: Offset(2, 2),
          blurRadius: 3,
          color: Colors.blueAccent.withOpacity(0.3),
        ),
        Shadow(
          offset: Offset(-2, -2),
          blurRadius: 3,
          color: Colors.blue.withOpacity(0.3),
        ),
      ],
    ),
  ),
),



                ),
              ),
            ),
          

          // 🔁 FIGURAS
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
                    CircleNode(
                        label: 'A',
                        color: Colors.redAccent,
                        alignment: Alignment(0, -1),
                        shape: NodeShape.circle),
                    CircleNode(
                        label: 'B',
                        color: Colors.orange,
                        alignment: Alignment(-1, 0),
                        shape: NodeShape.robot),
                    CircleNode(
                        label: 'C',
                        color: Colors.yellow,
                        alignment: Alignment(0, 1),
                        shape: NodeShape.book),
                    CircleNode(
                        label: 'D',
                        color: Colors.green,
                        alignment: Alignment(1, 0),
                        shape: NodeShape.person),
                  ],
                ),
              ),
            ),
          ),

          // 🤖 BOTÓN ROBOT CENTRADO
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  flagVueltas = !flagVueltas;
                });
              },
              child: CustomPaint(
                size: const Size(100, 100),
                painter: PlatePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
