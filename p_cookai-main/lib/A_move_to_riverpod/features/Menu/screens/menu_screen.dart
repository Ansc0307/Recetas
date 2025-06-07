
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../menu/widgets/plate_painter.dart';
import '../../menu/widgets/TableBackgroundPainter.dart';
import '../../menu/widgets/circle_node.dart';
import '../../menu/widgets/custom_shapes.dart';
import '../../menu/providers/show_nodes_provider.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showNodes = ref.watch(showNodesProvider);

    return Scaffold(
      body: CustomPaint(
        painter: TableBackgroundPainter(),
        child: Stack(
          children: [
            // Plato central
            Center(
              child: GestureDetector(
                onTap: () {
                  final current = ref.read(showNodesProvider.notifier).state;
                  ref.read(showNodesProvider.notifier).state = !current;
                },
                child: CustomPaint(
                  size: const Size(200, 200),
                  painter: PlatePainter(),
                ),
              ),
            ),

            // Título
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: showNodes ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: const Center(
                  child: Text(
                    'Tu Aplicación',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            // Nodos interactivos
            AnimatedOpacity(
              opacity: showNodes ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  CircleNode(
                    color: Colors.green,
                    label: 'B',
                    alignment: const Alignment(-0.8, -0.8),
                    shape: NodeShape.robot,
                  ),
                  CircleNode(
                    color: Colors.orange,
                    label: 'D',
                    alignment: const Alignment(0.8, -0.8),
                    shape: NodeShape.book,
                  ),
                  CircleNode(
                    color: Colors.blue,
                    label: 'A',
                    alignment: const Alignment(-0.8, 0.8),
                    shape: NodeShape.person,
                  ),
                  CircleNode(
                    color: Colors.red,
                    label: 'C',
                    alignment: const Alignment(0.8, 0.8),
                    shape: NodeShape.circle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
