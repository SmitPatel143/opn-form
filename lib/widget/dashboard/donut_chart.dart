// lib/widgets/donut_chart.dart
// Custom donut chart — zero dependencies, pure Flutter Canvas API.

import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  final int completed;
  final int total;
  final int target;
  final double size;

  const DonutChart({
    super.key,
    required this.completed,
    required this.total,
    required this.target,
    this.size = 110,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _DonutPainter(
              completed: completed,
              total: total,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$completed',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    TextSpan(
                      text: '/$total',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9AA0B2),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Target $target',
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF9AA0B2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final int completed;
  final int total;

  _DonutPainter({required this.completed, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width / 2 - 6;
    const strokeW = 10.0;

    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    // Background track
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi,
      false,
      Paint()
        ..color = const Color(0xFFEBEDF2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.round,
    );

    if (total == 0) return;

    // Completed arc (teal/green)
    final completedAngle = 2 * math.pi * (completed / total);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      completedAngle,
      false,
      Paint()
        ..color = const Color(0xFF00C1A2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.completed != completed || old.total != total;
}
