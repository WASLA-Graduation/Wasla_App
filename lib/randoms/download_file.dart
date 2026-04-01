import 'package:flutter/material.dart';

class DownloadFile extends StatelessWidget {
  const DownloadFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Paint")),

      body: Align(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CustomPaint(painter: _MyPainer()),
        ),
      ),
    );
  }
}

class _MyPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
