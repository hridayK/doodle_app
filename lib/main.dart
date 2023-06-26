import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DoodleApp(),
    );
  }
}

class DoodleApp extends StatefulWidget {
  const DoodleApp({super.key});

  @override
  State<DoodleApp> createState() => _DoodleAppState();
}

class _DoodleAppState extends State<DoodleApp> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doodle App 🖌️"),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {},
              child: CustomPaint(
                painter: BasicPainter(points: points),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    points.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erased Board'),
                    ),
                  );
                },
                child: const Text("Erase Board"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BasicPainter extends CustomPainter {
  BasicPainter({required this.points});
  List<Offset> points = [];

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  // Is called to check if the canvas should be re rendered or not
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // it would return false if the rendered drawing would not change
    return true;
  }
}
