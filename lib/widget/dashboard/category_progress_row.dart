// lib/widgets/category_progress_row.dart
// A single row showing category name + dual progress bar (completed green / expired red).

import 'package:flutter/material.dart';
import '../../model/dashboard/dashboard_models.dart';

class CategoryProgressRow extends StatelessWidget {
  final CategoryRow data;

  const CategoryProgressRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 4),
          // Dual progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                // background
                Container(height: 6, color: const Color(0xFFEBEDF2)),
                // completed (green)
                FractionallySizedBox(
                  widthFactor: data.completedRatio,
                  child: Container(height: 6, color: const Color(0xFF00C1A2)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          // Second bar for expired (red)
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(height: 6, color: const Color(0xFFEBEDF2)),
                FractionallySizedBox(
                  widthFactor: data.expiredRatio,
                  child: Container(height: 6, color: const Color(0xFFFF5252)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              _LegendDot(color: const Color(0xFF00C1A2)),
              const SizedBox(width: 3),
              Text('Completed ${data.completed}',
                  style: const TextStyle(fontSize: 9, color: Color(0xFF9AA0B2))),
              const SizedBox(width: 10),
              _LegendDot(color: const Color(0xFFFF5252)),
              const SizedBox(width: 3),
              Text('Expired ${data.expired}',
                  style: const TextStyle(fontSize: 9, color: Color(0xFF9AA0B2))),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
