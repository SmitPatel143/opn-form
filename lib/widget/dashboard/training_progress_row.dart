// lib/widgets/training_progress_row.dart
// Training row — name + single green progress bar + percentage label.

import 'package:flutter/material.dart';
import '../../model/dashboard/dashboard_models.dart';

class TrainingProgressRow extends StatelessWidget {
  final TrainingRow data;

  const TrainingProgressRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Training',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00C1A2),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Container(height: 6, color: const Color(0xFFEBEDF2)),
                      FractionallySizedBox(
                        widthFactor: data.percentage / 100,
                        child: Container(height: 6, color: const Color(0xFF00C1A2)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${data.percentage.toInt()}%',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF9AA0B2),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '${data.name} — ${data.completed} / ${data.required}',
            style: const TextStyle(fontSize: 9, color: Color(0xFF9AA0B2)),
          ),
        ],
      ),
    );
  }
}
